/*
 * Copyright © 2021 Kevin Omyonga
 */

import 'package:adaptive_chameleon_theme/src/services'
    '/shared_preferences_service.dart';
import 'package:adaptive_chameleon_theme/src/theme_collection.dart';
import 'package:flutter/material.dart';

/// Global InheritedWidget to access the data of the plugin
/// Current Theme related data or methods
class AdaptiveChameleonTheme extends InheritedWidget {
  final _AdaptiveChameleonThemeWidgetState data;

  const AdaptiveChameleonTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static _AdaptiveChameleonThemeWidgetState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AdaptiveChameleonTheme>()!.data;
  }

  @override
  bool updateShouldNotify(AdaptiveChameleonTheme oldWidget) {
    return this != oldWidget;
  }
}

/// Signature for the `builder` function which takes the [BuildContext] and
/// [ThemeData] as arguments and is responsible for returning a [Widget]
/// in the corresponding theme.
typedef ThemedWidgetBuilder = Widget Function(
    BuildContext context, ThemeData themeData, ThemeData darkThemeData,
    ThemeMode initialThemeMode);

/// Widget that will contains the whole app
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
    required this.darkThemeCollection,})
      : super(key: key);

  @override
  _AdaptiveChameleonThemeWidgetState createState() => _AdaptiveChameleonThemeWidgetState();
}

class _AdaptiveChameleonThemeWidgetState extends State<AdaptiveChameleonThemeWidget> {
  ThemeMode? themeMode;
  late SharedPreferencesService _prefs;
  Future? fInit;

  late ThemeData _currentTheme = ThemeData.fallback();
  late ThemeData _currentDarkTheme = ThemeData.fallback();
  int _currentThemeId = 0;

  /// Gets the theme currently set.
  ThemeData get theme => _currentTheme;
  ThemeData get darkTheme => _currentDarkTheme;

  /// Gets the id of the theme currently set.
  int get themeId => _currentThemeId;

  @override
  initState() {
    super.initState();
    fInit = _loadSharedPreferences();
  }

  /// Loads the Shared Preferences data stored on your device to build the UI accordingly
  Future _loadSharedPreferences() async {
    _prefs = SharedPreferencesService();
    if (widget.initialThemeMode != null) {
      themeMode = widget.initialThemeMode;

      _prefs.loadInstance();
      return;
    }

    _currentThemeId = widget.defaultThemeId;
    _currentTheme = widget.themeCollection[_currentThemeId];
    _currentDarkTheme = widget.darkThemeCollection[_currentThemeId];

    await _prefs.loadInstance();
    bool? isDark = _prefs.isDark();
    if (isDark != null) {
      themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    }

    int selectedThemeId = (_prefs.selectedThemeId() ?? widget.defaultThemeId);
    _currentTheme = widget.themeCollection[selectedThemeId];
    _currentDarkTheme = widget.darkThemeCollection[selectedThemeId];
    _currentThemeId = selectedThemeId;

    if (mounted) {
      setState(() {}); // Update
    }
  }

  /// Change your current ThemeMode
  ///
  /// If you do not send any parameter it will toggle in the following order:
  ///
  /// dynamic -> light -> dark -> dynamic ->
  ///
  /// Or you can define boolean values for the parameters "[dynamic]" and/or "[dark]"
  ///
  /// If the value of "[dynamic]" is true, it takes precedence over "[dark]"
  void changeThemeMode({bool? dynamic, bool? dark}) {
    if (dynamic == null && dark == null) {
      _toggleTheme();
      return;
    }

    ThemeMode? newThemeMode;
    bool forceDark = _prefs.isDark() ?? false;

    if (dark != null || dynamic != null) {
      forceDark = dark ?? forceDark;
      newThemeMode = (dynamic ?? false)
          ? ThemeMode.system
          : forceDark
          ? ThemeMode.dark
          : ThemeMode.light;
    }

    if (newThemeMode == ThemeMode.system) {
      _prefs.clearPref(SharePrefsAttribute.isDark);
    } else {
      _prefs.setIsDark(forceDark);
    }

    setState(() {
      themeMode = newThemeMode;
    });
  }

  /// Toggle from your current ThemeMode in the following order:
  ///
  /// dynamic -> light -> dark -> dynamic ->
  void _toggleTheme() {
    ThemeMode? currentThemeMode = themeMode;
    ThemeMode newThemeMode;
    bool? isNewThemeDark;

    if (currentThemeMode == ThemeMode.system) {
      newThemeMode = ThemeMode.light;
      isNewThemeDark = false;
    } else if (currentThemeMode == ThemeMode.light) {
      newThemeMode = ThemeMode.dark;
      isNewThemeDark = true;
    } else {
      newThemeMode = ThemeMode.system;
      isNewThemeDark = null;
    }

    if (isNewThemeDark == null) {
      _prefs.clearPref(SharePrefsAttribute.isDark);
    } else {
      _prefs.setIsDark(isNewThemeDark);
    }

    setState(() {
      themeMode = newThemeMode;
    });
  }

  /// Sets the theme of the app to the [ThemeData] that corresponds to the [themeId].
  /// If no [ThemeData] is registered for the given [themeId], the [ThemeCollection]s
  /// fallback theme is used.
  Future<void> setTheme(int themeId) async {
    setState(() {
      _currentTheme = widget.themeCollection[themeId];
      _currentDarkTheme = widget.darkThemeCollection[themeId];
      _currentThemeId = themeId;
    });

    _prefs.setSelectedThemeId(_currentThemeId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentTheme = widget.themeCollection[_currentThemeId];
    _currentDarkTheme = widget.darkThemeCollection[_currentThemeId];
  }

  @override
  Widget build(BuildContext context) {
    themeMode = themeMode ?? ThemeMode.system;
    return FutureBuilder(
      future: fInit,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AdaptiveChameleonTheme(
            data: this,
            child: widget.builder(context, _currentTheme, _currentDarkTheme,
                themeMode!),
          );
        }
        return Container(
          key: const Key('loading'),
        );
      },
    );
  }
}
