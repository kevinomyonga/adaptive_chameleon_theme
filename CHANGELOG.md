## 2025.7.0

- **Improved Theme Color Handling:**
  - Enhanced color brightness calculation in ThemeColorSelectorWidget to improve visibility on Material 3 surfaces.
  - Introduced getMaterialColorFromColor to generate full MaterialColor swatches from a single color input.
  - Added ability to retrieve unmodified theme colors, avoiding altered values from ColorScheme.
- **UI Enhancements:**
  - Refactored ThemeColorSelectorWidget to follow line length constraints and improve readability.
  - Improved contrast and appearance of selection borders in color selector buttons based on theme brightness.

## 2024.9.0

- **Code Formatting:**
  - Fixed formatting issues that impacted static analysis.

## 2024.8.1

- **Bug Fixes & Improvements:**
  - Resolved the problem where `AdaptiveChameleonThemeWidget` failed to load the system theme mode.

## 2024.8.0

- **Enhanced UI Components:**
  - Updated `ThemeColorSelectorWidget` to utilize Material 3 buttons.
  - Buttons in `ThemeColorSelectorWidget` now automatically wrap and adjust layout to fit smaller screen sizes, ensuring centering and even spacing.
- **Customizability:**
  - Added support for passing custom labels to `ThemeModeSelectorWidget`, with an option to include or exclude labels alongside icons.
- **Localization Support:**
  - Enabled localization for `ThemeModeSelectorWidget` by allowing custom text for labels.
- **Bug Fixes & Improvements:**
  - Fixed issues with theme configurations where elements from light themes appeared in dark themes.
  - Refined the theme selection process to ensure that a new random theme ID is selected if the currently active theme ID is chosen.

## 0.0.9

Updated plugin dependencies.
Added support for Material3.

## 0.0.8

Increased Unit Test Coverage.

## 0.0.7

Added Unit Tests.

## 0.0.6

Updated plugin dependencies.

## 0.0.5

Implemented theme color selector widget.
Implemented theme mode selector widget.

## 0.0.4

- Fixed Dart format issues.

## 0.0.3

Supports theme modes: light, dart, system default.
Supports colors for light and dart themes.
Persists theme customization across app restarts.
Allows to toggle theme mode between light and dark.
Allows to toggle between different theme colors.
Allows to set default theme.
Allows to reset to default theme.

## 0.0.2

Updated README

## 0.0.1

- Initial release.
