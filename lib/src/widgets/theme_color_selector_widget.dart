/*
 * Copyright © 2021-2024 Kevin Omyonga
 */

import 'package:adaptive_chameleon_theme/src/models/models.dart';
import 'package:adaptive_chameleon_theme/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// A widget that allows users to select a theme color from a collection of themes.
/// The buttons automatically wrap and adjust their layout to fit the available screen size.
class ThemeColorSelectorWidget extends StatelessWidget {
  const ThemeColorSelectorWidget({
    Key? key,
    required this.themeCollection,
    required this.selectedTheme,
    this.selectorSize = 42.0,
  }) : super(key: key);

  /// The collection of themes available for selection.
  final ThemeCollection themeCollection;

  /// The ID of the currently selected theme.
  final int selectedTheme;

  /// The size of each theme selector button. Defaults to 42.0.
  final double selectorSize;

  @override
  Widget build(BuildContext context) {
    return buildSelectorWidgets(context, themeCollection);
  }

  /// Builds the theme selector buttons as a [Wrap] widget, allowing them
  /// to wrap to the next line if the screen size is too small. The buttons
  /// are centered and evenly spaced.
  Widget buildSelectorWidgets(
      BuildContext context, ThemeCollection themeCollection) {
    final themeInfo = Theme.of(context);

    return Center(
      child: Wrap(
        key: const Key('ThemeColorSelectorWidget'),
        spacing: 16.0, // Horizontal spacing between buttons
        runSpacing: 12.0, // Vertical spacing between lines of buttons
        alignment: WrapAlignment.center, // Center the buttons horizontally
        children: themeCollection.themes.entries.map<Widget>((theme) {
            final themeColor = getShade(theme.value.colorScheme.primary);

          return ElevatedButton(
            onPressed: () {
              onThemeColorChanged(context, theme.key);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: themeColor,
              fixedSize: Size(selectorSize, selectorSize),
              shape: CircleBorder(
                side: BorderSide(
                  color: theme.key == selectedTheme
                      ? (themeInfo.brightness == Brightness.light
                          ? Colors.black
                          : Colors.white)
                      : Colors.grey,
                  width: 3.0,
                ),
              ),
            ),
            child: Semantics(
              selected: theme.key == selectedTheme,
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Handles the theme color change event.
  /// This method updates the theme by calling [setTheme] on the
  /// [AdaptiveChameleonTheme] context.
  void onThemeColorChanged(BuildContext context, int themeId) {
    AdaptiveChameleonTheme.of(context).setTheme(themeId);
  }

  /// Returns a brighter shade of the given [color].
  static Color getShade(Color color, {double value = 0.1}) {
    assert(value >= 0 && value <= 1, 'Value must be between 0 and 1.');
    final hsl = HSLColor.fromColor(color);
    final hslBright = hsl.withLightness(
      (hsl.lightness + value).clamp(0.0, 1.0),
    );
    return hslBright.toColor();
  }
}
