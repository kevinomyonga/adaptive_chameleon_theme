import 'package:adaptive_chameleon_theme/adaptive_chameleon_theme.dart';
import 'package:flutter/material.dart';

class AppThemes {
  // MotyBase Base Theme Data
  static ThemeData baseTheme({
    MaterialColor? primarySwatch,
    bool isDark = false,
  }) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primarySwatch: primarySwatch,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      useMaterial3: true,
    );
  }

  // MotyBase Base Dark Theme Data
  static ThemeData baseDarkTheme({MaterialColor? primarySwatch}) {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: primarySwatch,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      useMaterial3: true,
    );
  }

  // Akainu Theme Data
  static ThemeData akainuTheme() {
    return baseTheme().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.red,
        primary: Colors.red,
      ),
    );
  }

  static ThemeData akainuDarkTheme() {
    return baseDarkTheme().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.red,
        primary: Colors.red,
        brightness: Brightness.dark,
      ),
    );
  }

  // Aokiji Theme Data
  static ThemeData aokijiTheme() {
    return baseTheme().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        primary: Colors.blue,
      ),
    );
  }

  static ThemeData aokijiDarkTheme() {
    return baseDarkTheme().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        primary: Colors.blue,
        brightness: Brightness.dark,
      ),
    );
  }

  // Fujitora Theme Data (Default)
  static ThemeData fujitoraTheme() {
    return baseTheme().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.purple,
        primary: Colors.purple,
      ),
    );
  }

  static ThemeData fujitoraDarkTheme() {
    return baseDarkTheme().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.purple,
        primary: Colors.purple,
        brightness: Brightness.dark,
      ),
    );
  }

  // Kizaru Theme Data
  static ThemeData kizaruTheme() {
    return baseTheme().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.yellow,
        primary: Colors.yellow,
      ),
    );
  }

  static ThemeData kizaruDarkTheme() {
    return baseDarkTheme().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.yellow,
        primary: Colors.yellow,
        brightness: Brightness.dark,
      ),
    );
  }

  // Ryokugyu Theme Data
  static ThemeData ryokugyuTheme() {
    return baseTheme().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
        primary: Colors.green,
      ),
    );
  }

  static ThemeData ryokugyuDarkTheme() {
    return baseDarkTheme().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
        primary: Colors.green,
        brightness: Brightness.dark,
      ),
    );
  }

  /// The app's themes.
  /// This code is used to connect readable names
  /// to integer theme IDs.
  static const int akainu = 0;
  static const int aokiji = 1;
  static const int kizaru = 2;
  static const int fujitora = 3;
  static const int ryokugyu = 4;

  static String toStr(int themeId) {
    switch (themeId) {
      case akainu:
        return "Akainu";
      case aokiji:
        return "Aokiji";
      case kizaru:
        return "Kizaru";
      case fujitora:
        return "Fujitora";
      case ryokugyu:
        return "Ryokugyu";
      default:
        return "Unknown";
    }
  }

  static ThemeCollection themeCollection = ThemeCollection(
    themes: {
      akainu: akainuTheme(),
      aokiji: aokijiTheme(),
      kizaru: kizaruTheme(),
      fujitora: fujitoraTheme(),
      ryokugyu: ryokugyuTheme(),
    },
    fallbackTheme: ThemeData.light(), // optional fallback theme, default value
    // is ThemeData.light()
  );

  static ThemeCollection darkThemeCollection = ThemeCollection(
    themes: {
      akainu: akainuDarkTheme(),
      aokiji: aokijiDarkTheme(),
      kizaru: kizaruDarkTheme(),
      fujitora: fujitoraDarkTheme(),
      ryokugyu: ryokugyuDarkTheme(),
    },
    fallbackTheme: ThemeData.dark(), // optional fallback theme, default value
    // is ThemeData.dark()
  );
}
