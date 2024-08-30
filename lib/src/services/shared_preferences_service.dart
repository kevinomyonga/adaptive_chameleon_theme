/*
 * Copyright © 2021-2024 Kevin Omyonga
 */

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

/// Enum representing the different attributes that can be stored in SharedPreferences.
enum SharePrefsAttribute {
  isDark,
  selectedThemeId,
}

/// Extension to convert SharePrefsAttribute values to string.
extension ParseToString on SharePrefsAttribute {
  String toShortString() {
    return toString().split('.').last.toLowerCase();
  }
}

/// A service class to handle SharedPreferences operations.
/// This class provides methods to load, save, and clear preferences.
class SharedPreferencesService {
  SharedPreferences? prefs;

  /// Asynchronously loads the SharedPreferences instance.
  Future<void> loadInstance() async {
    prefs = await SharedPreferences.getInstance();
  }

  /// Retrieves the 'isDark' boolean value from SharedPreferences.
  /// Returns null if the value is not set.
  bool? isDark() {
    return prefs?.getBool(SharePrefsAttribute.isDark.toShortString());
  }

  /// Saves the 'isDark' boolean value to SharedPreferences.
  Future<bool> setIsDark(bool value) async {
    return await prefs!
        .setBool(SharePrefsAttribute.isDark.toShortString(), value);
  }

  /// Retrieves the 'selectedThemeId' integer value from SharedPreferences.
  /// Returns null if the value is not set.
  int? selectedThemeId() {
    return prefs?.getInt(SharePrefsAttribute.selectedThemeId.toShortString());
  }

  /// Saves the 'selectedThemeId' integer value to SharedPreferences.
  Future<bool> setSelectedThemeId(int value) async {
    return await prefs!
        .setInt(SharePrefsAttribute.selectedThemeId.toShortString(), value);
  }

  /// Removes a specific preference identified by the given attribute.
  Future<bool> clearPref(SharePrefsAttribute attribute) async {
    return await prefs!.remove(attribute.toShortString());
  }
}
