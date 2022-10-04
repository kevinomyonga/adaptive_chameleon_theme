import 'package:adaptive_chameleon_theme/src/services/shared_preferences_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferencesService prefs;
  late bool? isDark;
  late int? selectedThemeId;

  setUp(() async {
    // Before you use shared preferences add this line. If you even use normal
    // getString, the internal program uses getAll so it will still crash
    SharedPreferences.setMockInitialValues({});
    prefs = SharedPreferencesService();
    await prefs.loadInstance();
  });

  group('SharedPreferenceService', () {
    test('Returns Null if empty', () {
      // Dark Mode
      isDark = prefs.isDark();
      expect(isDark, null);

      // Theme Color
      selectedThemeId = prefs.selectedThemeId();
      expect(selectedThemeId, null);
    });

    test('Can retrieve preferences', () async {
      // Dark Mode
      await prefs.setIsDark(false);
      isDark = prefs.isDark();

      expect(isDark, false);

      // Theme Color
      await prefs.setSelectedThemeId(0);
      selectedThemeId = prefs.selectedThemeId();

      expect(selectedThemeId, 0);
    });

    test('Can update preferences', () async {
      // Dark Mode
      await prefs.setIsDark(false);
      isDark = prefs.isDark();
      expect(isDark, false);

      await prefs.setIsDark(true);
      isDark = prefs.isDark();
      expect(isDark, true);

      // Theme Color
      await prefs.setSelectedThemeId(0);
      selectedThemeId = prefs.selectedThemeId();
      expect(selectedThemeId, 0);

      await prefs.setSelectedThemeId(2);
      selectedThemeId = prefs.selectedThemeId();
      expect(selectedThemeId, 2);
    });

    test('Can delete preferences', () async {
      // Dark Mode
      await prefs.setIsDark(true);
      isDark = prefs.isDark();
      expect(isDark, true);

      await prefs.clearPref(SharePrefsAttribute.isDark);
      isDark = prefs.isDark();
      expect(isDark, null);

      // Theme Color
      await prefs.setSelectedThemeId(1);
      selectedThemeId = prefs.selectedThemeId();
      expect(selectedThemeId, 1);

      await prefs.clearPref(SharePrefsAttribute.selectedThemeId);
      selectedThemeId = prefs.selectedThemeId();
      expect(selectedThemeId, null);
    });
  });
}
