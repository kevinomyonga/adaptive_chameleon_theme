/*
 * Copyright © 2021 Kevin Omyonga
 */

import 'package:adaptive_chameleon_theme/src/services/shared_preferences_service.dart';
import 'package:adaptive_chameleon_theme/src/widget/adaptive_chameleon_widget.dart';
import 'package:flutter/material.dart';

class ThemeModeSelectorWidget extends StatefulWidget {
  const ThemeModeSelectorWidget({Key? key}) : super(key: key);

  @override
  _ThemeModeSelectorWidgetState createState() =>
      _ThemeModeSelectorWidgetState();
}

class _ThemeModeSelectorWidgetState extends State<ThemeModeSelectorWidget> {
  ThemeMode? themeMode;
  late SharedPreferencesService _prefs;

  List<bool> selectionList = [false, true, false];

  @override
  void initState() {
    super.initState();

    _loadSharedPreferences();
  }

  /// Loads the Shared Preferences data stored on your device to build the
  /// UI accordingly
  Future _loadSharedPreferences() async {
    _prefs = SharedPreferencesService();

    await _prefs.loadInstance();
    bool? isDark = _prefs.isDark();
    if (isDark != null) {
      themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    } else {
      themeMode = ThemeMode.system;
    }

    setState(() {
      switch (themeMode) {
        case ThemeMode.light:
          selectionList = [true, false, false];
          break;
        case ThemeMode.system:
          selectionList = [false, true, false];
          break;
        case ThemeMode.dark:
          selectionList = [false, false, true];
          break;
        default:
          selectionList = [false, true, false];
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildSelectorWidgets();
  }

  Widget buildSelectorWidgets() {
    return ToggleButtons(
      children: const <Widget>[
        Icon(Icons.brightness_high),
        Icon(Icons.brightness_auto),
        Icon(Icons.brightness_4),
      ],
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < selectionList.length; i++) {
            if (i == index) {
              selectionList[i] = true;
            } else {
              selectionList[i] = false;
            }
          }
        });

        switch (index) {
          case 0:
            AdaptiveChameleonTheme.of(context).changeThemeMode(dark: false);
            break;
          case 1:
            AdaptiveChameleonTheme.of(context).changeThemeMode(dynamic: true);
            break;
          case 2:
            AdaptiveChameleonTheme.of(context).changeThemeMode(dark: true);
            break;
        }
      },
      isSelected: selectionList,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    );
  }
}
