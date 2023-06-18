import 'package:adaptive_chameleon_theme/adaptive_chameleon_theme.dart';
import 'package:flutter/material.dart';

class AppThemes {
  // MotyBase Base Theme Data
  static ThemeData baseTheme(
      {MaterialColor? primarySwatch, bool isDark = false}) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primarySwatch: primarySwatch,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
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
      appBarTheme: const AppBarTheme(
        color: Colors.black,
      ),
      useMaterial3: true,
    );
  }

  // Akainu Theme Data
  static ThemeData akainuTheme() {
    final base = baseTheme(
      primarySwatch: Colors.red,
    );
    return base.copyWith(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.red,
      ),
    );
  }

  static ThemeData akainuDarkTheme() {
    final base = baseDarkTheme(
      primarySwatch: Colors.red,
    );
    return base.copyWith(
      colorScheme: const ColorScheme.dark(
        primary: Colors.red,
        secondary: Colors.red,
      ),
    );
  }

  // Aokiji Theme Data
  static ThemeData aokijiTheme() {
    return ThemeData(
      colorSchemeSeed: Colors.blue,
      useMaterial3: true,
    );
  }

  static ThemeData aokijiDarkTheme() {
    return ThemeData.from(
      colorScheme:
          const ColorScheme.dark(primary: Colors.blue, secondary: Colors.blue),
      useMaterial3: true,
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
