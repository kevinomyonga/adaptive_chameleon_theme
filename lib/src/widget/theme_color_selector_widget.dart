import 'package:adaptive_chameleon_theme/src/theme_collection.dart';
import 'package:flutter/material.dart';

import 'package:adaptive_chameleon_theme/src/widget/adaptive_chameleon_widget.dart';

class ThemeColorSelectorWidget extends StatefulWidget {
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
  _ThemeColorSelectorWidgetState createState() =>
      _ThemeColorSelectorWidgetState();
}

class _ThemeColorSelectorWidgetState extends State<ThemeColorSelectorWidget> {
  //late ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return buildSelectorWidgets(widget.themeCollection);
  }

  Widget buildSelectorWidgets(ThemeCollection themeCollection) {
    final themeInfo = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: themeCollection.themes.entries.map<Widget>((theme) {
        return RawMaterialButton(
          onPressed: () {
            onThemeColorChanged(theme.key);
          },
          constraints: BoxConstraints.tightFor(
            width: widget.selectorSize,
            height: widget.selectorSize,
          ),
          fillColor: theme.value.primaryColor,
          shape: CircleBorder(
            side: BorderSide(
              color: theme.key == widget.selectedTheme
                  ? (themeInfo.brightness == Brightness.light
                      ? Colors.black
                      : Colors.white)
                  : Colors.grey,
              width: 3.0,
            ),
          ),
          child: Semantics(
            selected: theme.key == widget.selectedTheme,
          ),
        );
      }).toList(),
    );
  }

  void onThemeColorChanged(int themeId) {
    AdaptiveChameleonTheme.of(context).setTheme(themeId);
  }
}
