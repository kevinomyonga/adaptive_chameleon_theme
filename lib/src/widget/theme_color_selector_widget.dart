import 'package:adaptive_chameleon_theme/src/theme_collection.dart';
import 'package:flutter/material.dart';

class ThemeColorSelectorWidget extends StatelessWidget {

  final ThemeCollection themeCollection;
  final int selectedTheme;

  final double selectorSize;

  final ValueChanged<int> onChanged;

  const ThemeColorSelectorWidget({
    Key? key,
    required this.themeCollection,
    required this.selectedTheme,
    this.selectorSize = 42.0,
    required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSelectorWidgets(themeCollection);
  }

  Widget buildSelectorWidgets(ThemeCollection themeCollection) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: themeCollection.themes.entries.map<Widget>((theme) {
        return RawMaterialButton(
          onPressed: () {
            onChanged(theme.key);
          },
          constraints: BoxConstraints.tightFor(
            width: selectorSize,
            height: selectorSize,
          ),
          fillColor: theme.value.primaryColor,
          shape: CircleBorder(
            side: BorderSide(
              color: theme.key == selectedTheme ? Colors.black : Colors.grey,
              width: 3.0,
            ),
          ),
          child: Semantics(
            value: "namedTheme.name",
            selected: theme.key == selectedTheme,
          ),
        );
      }).toList(),
    );
  }
}