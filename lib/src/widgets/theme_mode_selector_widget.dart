/*
 * Copyright © 2021-2024 Kevin Omyonga
 */

import 'package:adaptive_chameleon_theme/src/services/services.dart';
import 'package:adaptive_chameleon_theme/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// A widget that allows users to select a theme mode (Light, System, Dark)
/// using segmented buttons. The buttons can be customized with optional
/// labels, and the selection is persisted using shared preferences.
class ThemeModeSelectorWidget extends StatefulWidget {
  const ThemeModeSelectorWidget({
    Key? key,
    this.lightLabel = 'Light', // Default label for the light theme button
    this.systemLabel = 'System', // Default label for the system theme button
    this.darkLabel = 'Dark', // Default label for the dark theme button
    this.showLabels = true, // Default to showing labels with the icons
  }) : super(key: key);

  /// The label to be displayed for the light theme mode button.
  /// If not provided, it defaults to 'Light'.
  final String lightLabel;

  /// The label to be displayed for the system theme mode button.
  /// If not provided, it defaults to 'System'.
  final String systemLabel;

  /// The label to be displayed for the dark theme mode button.
  /// If not provided, it defaults to 'Dark'.
  final String darkLabel;

  /// A flag indicating whether to show labels alongside icons.
  /// Defaults to `true`, meaning labels will be displayed.
  final bool showLabels;

  @override
  ThemeModeSelectorWidgetState createState() => ThemeModeSelectorWidgetState();
}

/// State class for [ThemeModeSelectorWidget].
///
/// Handles loading the current theme mode from shared preferences,
/// displaying the appropriate buttons, and updating the theme mode when
/// a different option is selected.
class ThemeModeSelectorWidgetState extends State<ThemeModeSelectorWidget> {
  // Current theme mode. It can be Light, System, or Dark.
  ThemeMode? themeMode;
  
  // Service for accessing shared preferences to store and retrieve the user's theme mode choice.
  late SharedPreferencesService _prefs;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences(); // Load the user's theme mode preference when the widget is initialized.
  }

  /// Loads the user's theme mode preference from shared preferences.
  ///
  /// This method checks if the user has a saved preference for dark mode.
  /// If so, it sets the [themeMode] accordingly; otherwise, it defaults to
  /// the system theme mode. The UI is updated to reflect this choice.
  Future _loadSharedPreferences() async {
    _prefs = SharedPreferencesService();

    await _prefs.loadInstance();
    
    // Retrieve the saved preference for dark mode.
    bool? isDark = _prefs.isDark();
    
    // Set the themeMode based on the saved preference or default to system mode.
    if (isDark != null) {
      themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    } else {
      themeMode = ThemeMode.system;
    }

    // Trigger a rebuild to reflect the loaded theme mode.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Build and return the segmented buttons for theme mode selection.
    return buildSelectorWidgets();
  }

  /// Builds the segmented buttons for selecting the theme mode.
  ///
  /// The buttons are created using the [SegmentedButton] widget,
  /// with options for Light, System, and Dark theme modes. The labels
  /// are only shown if [widget.showLabels] is true.
  Widget buildSelectorWidgets() {
    return SegmentedButton<ThemeMode>(
      // Define the segments, each corresponding to a theme mode.
      segments: <ButtonSegment<ThemeMode>>[
        ButtonSegment<ThemeMode>(
          value: ThemeMode.light,
          // Show label if [showLabels] is true, otherwise show only the icon.
          label: widget.showLabels ? Text(widget.lightLabel) : null,
          icon: const Icon(Icons.brightness_high), // Icon for the light theme
        ),
        ButtonSegment<ThemeMode>(
          value: ThemeMode.system,
          label: widget.showLabels ? Text(widget.systemLabel) : null,
          icon: const Icon(Icons.brightness_auto), // Icon for the system theme
        ),
        ButtonSegment<ThemeMode>(
          value: ThemeMode.dark,
          label: widget.showLabels ? Text(widget.darkLabel) : null,
          icon: const Icon(Icons.brightness_4), // Icon for the dark theme
        ),
      ],
      // Set the selected segment based on the current theme mode.
      selected: <ThemeMode>{themeMode ?? ThemeMode.system},
      
      // Callback triggered when the user selects a different theme mode.
      onSelectionChanged: (Set<ThemeMode> newSelection) {
        if (newSelection.isNotEmpty) {
          setState(() {
            themeMode = newSelection.first; // Update the selected theme mode.
          });

          // Apply the selected theme mode using the AdaptiveChameleonTheme service.
          switch (themeMode) {
            case ThemeMode.light:
              AdaptiveChameleonTheme.of(context).changeThemeMode(dark: false);
              break;
            case ThemeMode.system:
              AdaptiveChameleonTheme.of(context).changeThemeMode(dynamic: true);
              break;
            case ThemeMode.dark:
              AdaptiveChameleonTheme.of(context).changeThemeMode(dark: true);
              break;
            default:
              AdaptiveChameleonTheme.of(context).changeThemeMode(dynamic: true);
              break;
          }
        }
      },
    );
  }
}
