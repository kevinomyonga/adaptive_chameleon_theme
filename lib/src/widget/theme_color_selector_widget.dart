/*
 * Copyright © 2021-2022 Kevin Omyonga
 */

import 'package:adaptive_chameleon_theme/src/theme_collection.dart';
import 'package:adaptive_chameleon_theme/src/widget/adaptive_chameleon_widget.dart';
import 'package:flutter/material.dart';

class ThemeColorSelectorWidget extends StatelessWidget {
  const ThemeColorSelectorWidget({
    Key? key,
    required this.themeCollection,
    required this.selectedTheme,
    this.selectorSize = 42.0,
  }) : super(key: key);

  final ThemeCollection themeCollection;
  final int selectedTheme;

  final double selectorSize;

  @override
  Widget build(BuildContext context) {
    return buildSelectorWidgets(context, themeCollection);
  }

  Widget buildSelectorWidgets(
      BuildContext context, ThemeCollection themeCollection) {
    final themeInfo = Theme.of(context);

    return Row(
      key: const Key('ThemeColorSelectorWidget'),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: themeCollection.themes.entries.map<Widget>((theme) {
        return RawMaterialButton(
          onPressed: () {
            onThemeColorChanged(context, theme.key);
          },
          constraints: BoxConstraints.tightFor(
            width: selectorSize,
            height: selectorSize,
          ),
          fillColor: theme.value.primaryColor,
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
          child: Semantics(
            selected: theme.key == selectedTheme,
          ),
        );
      }).toList(),
    );
  }

  void onThemeColorChanged(BuildContext context, int themeId) {
    AdaptiveChameleonTheme.of(context).setTheme(themeId);
  }
}
