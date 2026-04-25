/*
 * Copyright © 2021-2026 Kevin Omyonga
 */

import 'package:adaptive_chameleon_theme/src/services/services.dart';
import 'package:adaptive_chameleon_theme/src/models/models.dart';
import 'package:flutter/material.dart';

/// Global InheritedWidget to access the theme data and methods of the plugin.
///
/// This widget provides access to the theme data and related methods
/// throughout the widget tree. It allows widgets to get the current
/// theme settings and change them if needed.
class AdaptiveChameleonTheme extends InheritedWidget {
  final AdaptiveChameleonThemeWidgetState data;

  const AdaptiveChameleonTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Returns the nearest [AdaptiveChameleonTheme] instance up the widget tree.
  /// Throws an error if no [AdaptiveChameleonTheme] is found.
  static AdaptiveChameleonThemeWidgetState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AdaptiveChameleonTheme>()!
        .data;
  }

  @override
  bool updateShouldNotify(AdaptiveChameleonTheme oldWidget) {
    // Notifies the widget if the [AdaptiveChameleonTheme] instance has changed.
    return this != oldWidget;
  }
}

/// Signature for the `builder` function which takes the [BuildContext] and
/// [ThemeData] as arguments and is responsible for returning a [Widget]
/// in the corresponding theme.
///
/// This function is used to build the main widget tree of the app using the
/// current theme and theme mode.
typedef ThemedWidgetBuilder = Widget Function(BuildContext context,
    ThemeData themeData, ThemeData darkThemeData, ThemeMode initialThemeMode);

/// Widget that contains the whole app and manages the theme.
///
/// This widget is responsible for setting up the theme mode and providing
/// the necessary theme data to the rest of the app. It allows users to
/// switch between light and dark themes and maintain their preferences.
class AdaptiveChameleonThemeWidget extends StatefulWidget {
  final ThemeMode?
      initialThemeMode; // Initial theme mode (light, dark, system).
  final ThemedWidgetBuilder builder; // Function to build the app's main UI.
  final int defaultThemeId; // Default theme ID if no previous theme is set.
  final ThemeCollection themeCollection; // Collection of light themes.
  final ThemeCollection darkThemeCollection; // Collection of dark themes.

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
  ThemeMode? themeMode; // Current theme mode (light, dark, or system).
  late SharedPreferencesService _prefs; // Service to handle shared preferences.
  Future? fInit; // Future for initializing shared preferences.

  late ThemeData _currentTheme = ThemeData.fallback(); // Current light theme.
  late ThemeData _currentDarkTheme =
      ThemeData.fallback(); // Current dark theme.
  int _currentThemeId = 0; // ID of the currently applied theme.

  /// Gets the theme currently set.
  ThemeData get theme => _currentTheme;

  /// Gets the dark theme currently set.
  ThemeData get darkTheme => _currentDarkTheme;

  /// Gets the ID of the theme currently set.
  int get themeId => _currentThemeId;

  @override
  void initState() {
    super.initState();
    // Initialize shared preferences and load the current theme.
    fInit = _loadSharedPreferences();
  }

  /// Loads the theme and theme mode settings from shared preferences.
  ///
  /// This method retrieves the stored theme preferences and updates the
  /// theme mode and theme data accordingly.
  Future _loadSharedPreferences() async {
    _prefs = SharedPreferencesService();
    if (widget.initialThemeMode != null) {
      // If an initial theme mode is provided, use it directly.
      themeMode = widget.initialThemeMode;
      _prefs.loadInstance();
      return;
    }

    // Load default theme settings.
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
      setState(() {}); // Trigger a rebuild with the new theme data.
    }
  }

  /// Changes the current theme mode.
  ///
  /// If no parameters are provided, toggles the theme mode between
  /// dynamic, light, and dark. You can also specify boolean values for
  /// [dynamic] and [dark] to control the theme mode directly.
  void changeThemeMode({bool? dynamic, bool? dark}) {
    if (dynamic == null && dark == null) {
      // If no parameters, toggle the theme mode.
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

  /// Toggles the current theme mode in the order:
  /// dynamic -> light -> dark -> dynamic.
  ///
  /// This method cycles through the available theme modes and updates
  /// the stored preferences accordingly.
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

  /// Sets the theme of the app to the [ThemeData] that corresponds to the
  /// [themeId].
  ///
  /// If no [ThemeData] is registered for the given [themeId], the fallback
  /// theme from the [ThemeCollection] is used. The selected theme ID is
  /// stored in shared preferences.
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
    // Update the current theme data when dependencies change.
    _currentTheme = widget.themeCollection[_currentThemeId];
    _currentDarkTheme = widget.darkThemeCollection[_currentThemeId];
  }

  @override
  Widget build(BuildContext context) {
    // Default to system theme mode if not set.
    themeMode = themeMode ?? ThemeMode.system;
    return FutureBuilder(
      future: fInit,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Build the widget tree with the current theme data.
          return AdaptiveChameleonTheme(
            data: this,
            child: widget.builder(
                context, _currentTheme, _currentDarkTheme, themeMode!),
          );
        }
        // Show a loading widget until shared preferences are loaded.
        return Container(
          key: const Key('loading'),
        );
      },
    );
  }
}
