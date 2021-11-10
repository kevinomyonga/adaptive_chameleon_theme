import 'package:adaptive_chameleon_theme/adaptive_chameleon_theme.dart';
import 'package:flutter/material.dart';

class AppThemes {
  // Akainu Theme Data
  static ThemeData akainuTheme() {
    return ThemeData(
      primarySwatch: Colors.red,
    );
  }

  static ThemeData akainuDarkTheme() {
    return ThemeData.from(
      colorScheme:
          const ColorScheme.dark(primary: Colors.red, secondary: Colors.red),
    );
  }

  // Aokiji Theme Data
  static ThemeData aokijiTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
    );
  }

  static ThemeData aokijiDarkTheme() {
    return ThemeData.from(
      colorScheme:
          const ColorScheme.dark(primary: Colors.blue, secondary: Colors.blue),
    );
  }

  // Fujitora Theme Data (Default)
  static ThemeData fujitoraTheme() {
    return ThemeData(
      primarySwatch: Colors.purple,
    );
  }

  static ThemeData fujitoraDarkTheme() {
    return ThemeData.from(
      colorScheme: const ColorScheme.dark(
          primary: Colors.purple, secondary: Colors.purple),
    );
  }

  // Kizaru Theme Data
  static ThemeData kizaruTheme() {
    return ThemeData(
      primarySwatch: Colors.amber,
    );
  }

  static ThemeData kizaruDarkTheme() {
    return ThemeData.from(
      colorScheme: const ColorScheme.dark(
          primary: Colors.amber, secondary: Colors.amber),
    );
  }

  // Ryokugyu Theme Data
  static ThemeData ryokugyuTheme() {
    return ThemeData(
      primarySwatch: Colors.green,
    );
  }

  static ThemeData ryokugyuDarkTheme() {
    return ThemeData.from(
      colorScheme: const ColorScheme.dark(
          primary: Colors.green, secondary: Colors.green),
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
