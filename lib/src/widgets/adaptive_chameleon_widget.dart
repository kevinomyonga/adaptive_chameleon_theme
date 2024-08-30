/*
 * Copyright © 2021-2024 Kevin Omyonga
 */

import 'package:adaptive_chameleon_theme/src/services/services.dart';
import 'package:adaptive_chameleon_theme/src/models/models.dart';
import 'package:flutter/material.dart';

/// Global InheritedWidget for accessing theme-related data and methods
class AdaptiveChameleonTheme extends InheritedWidget {
  final AdaptiveChameleonThemeWidgetState data;

  const AdaptiveChameleonTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  /// Provides access to theme data and methods from the widget tree
  static AdaptiveChameleonThemeWidgetState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AdaptiveChameleonTheme>()!
        .data;
  }

  @override
  bool updateShouldNotify(AdaptiveChameleonTheme oldWidget) {
    return this != oldWidget;
  }
}

/// Signature for the `builder` function, which returns a themed [Widget]
typedef ThemedWidgetBuilder = Widget Function(BuildContext context,
    ThemeData themeData, ThemeData darkThemeData, ThemeMode themeMode);

/// Main widget that encapsulates the entire app
class AdaptiveChameleonThemeWidget extends StatefulWidget {
  final ThemeMode? initialThemeMode;
  final ThemedWidgetBuilder builder;
  final int defaultThemeId;
  final ThemeCollection themeCollection;
  final ThemeCollection darkThemeCollection;

  const AdaptiveChameleonThemeWidget({
    Key? key,
    this.initialThemeMode,
    required this.builder,
    this.defaultThemeId = 0,
    required this.themeCollection,
    required this.darkThemeCollection,
  }) : super(key: key);

  @override
  AdaptiveChameleonThemeWidgetState createState() =>
      AdaptiveChameleonThemeWidgetState();
}

class AdaptiveChameleonThemeWidgetState
    extends State<AdaptiveChameleonThemeWidget> {
  ThemeMode? themeMode;
  late SharedPreferencesService _prefs;
  Future? fInit;

  late ThemeData _currentTheme;
  late ThemeData _currentDarkTheme;
  int _currentThemeId = 0;

  /// Provides access to the currently set theme
  ThemeData get theme => _currentTheme;
  ThemeData get darkTheme => _currentDarkTheme;

  /// Provides access to the currently set theme ID
  int get themeId => _currentThemeId;

  @override
  void initState() {
    super.initState();
    _currentTheme = ThemeData.fallback();
    _currentDarkTheme = ThemeData.fallback();
    fInit = _loadSharedPreferences();
  }

  /// Loads SharedPreferences data to build the UI accordingly
  Future<void> _loadSharedPreferences() async {
    _prefs = SharedPreferencesService();
    themeMode = widget.initialThemeMode;
    await _prefs.loadInstance();

    _currentThemeId = _prefs.selectedThemeId() ?? widget.defaultThemeId;
    _currentTheme = widget.themeCollection[_currentThemeId];
    _currentDarkTheme = widget.darkThemeCollection[_currentThemeId];

    themeMode ??= _prefs.isDark() == true
        ? ThemeMode.dark
        : ThemeMode.light;
    
    if (mounted) {
      setState(() {}); // Update the UI
    }
  }

  /// Changes the current theme mode with optional parameters
  void changeThemeMode({bool? dynamic, bool? dark}) {
    if (dynamic == null && dark == null) {
      _toggleTheme();
      return;
    }

    bool forceDark = _prefs.isDark() ?? false;
    themeMode = (dynamic == true)
        ? ThemeMode.system
        : (dark ?? forceDark)
            ? ThemeMode.dark
            : ThemeMode.light;

    forceDark ? _prefs.setIsDark(forceDark)
              : _prefs.clearPref(SharePrefsAttribute.isDark);

    setState(() {});
  }

  /// Toggles between the theme modes: system -> light -> dark -> system ->
  void _toggleTheme() {
    switch (themeMode) {
      case ThemeMode.system:
        themeMode = ThemeMode.light;
        _prefs.setIsDark(false);
        break;
      case ThemeMode.light:
        themeMode = ThemeMode.dark;
        _prefs.setIsDark(true);
        break;
      default:
        themeMode = ThemeMode.system;
        _prefs.clearPref(SharePrefsAttribute.isDark);
    }
    setState(() {});
  }

  /// Sets the theme based on the provided [themeId]
  Future<void> setTheme(int themeId) async {
    setState(() {
      _currentTheme = widget.themeCollection[themeId];
      _currentDarkTheme = widget.darkThemeCollection[themeId];
      _currentThemeId = themeId;
    });
    _prefs.setSelectedThemeId(themeId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentTheme = widget.themeCollection[_currentThemeId];
    _currentDarkTheme = widget.darkThemeCollection[_currentThemeId];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fInit,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AdaptiveChameleonTheme(
            data: this,
            child: widget.builder(
              context, _currentTheme, _currentDarkTheme, themeMode ?? ThemeMode.system
            ),
          );
        }
        return const SizedBox.shrink(); // Placeholder while loading
      },
    );
  }
}
