/*
 * Copyright © 2021 Kevin Omyonga
 */

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

enum SharePrefsAttribute {
  isDark,
  selectedThemeId,
}

extension ParseToString on SharePrefsAttribute {
  String toShortString() {
    return toString().split('.').last.toLowerCase();
  }
}

class SharedPreferencesService {
  SharedPreferences? _prefs;
  get prefs => _prefs;
  set prefs(instance) => _prefs = instance;

  Future loadInstance() async => _prefs = await SharedPreferences.getInstance();

  bool? isDark() =>
      _prefs!.getBool(SharePrefsAttribute.isDark.toShortString());

  setIsDark(bool value) =>
      _prefs!.setBool(SharePrefsAttribute.isDark.toShortString(), value);

  int? selectedThemeId() =>
      _prefs!.getInt(SharePrefsAttribute.selectedThemeId.toShortString());

  setSelectedThemeId(int value) =>
      _prefs!.setInt(SharePrefsAttribute.selectedThemeId.toShortString(),
          value);

  clearPref(SharePrefsAttribute attribute) =>
      _prefs!.remove(attribute.toShortString());
}
