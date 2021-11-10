import 'package:example/themes.dart';
import 'package:flutter/material.dart';

import 'package:adaptive_chameleon_theme/adaptive_chameleon_theme.dart';


void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveChameleonThemeWidget(
        themeCollection: AppThemes.themeCollection,
        darkThemeCollection: AppThemes.darkThemeCollection,
        defaultThemeId: AppThemes.aokiji,
        builder: (context, theme, darkTheme, themeMode) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: theme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            home: const MyHomePage(title: 'Adaptive Chameleon Theme'),
          );
        }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int dropdownValue = 0;
  ThemeMode themeModeDropdownValue = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    dropdownValue = AdaptiveChameleonTheme.of(context).themeId;
    themeModeDropdownValue = AdaptiveChameleonTheme.of(context).themeMode!;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 24, bottom: 12),
              child: Text('Select your theme color here:'),
            ),
            DropdownButton(
                icon: const Icon(Icons.arrow_downward),
                value: dropdownValue,
                items: [
                  DropdownMenuItem(
                    value: AppThemes.akainu,
                    child: Text(AppThemes.toStr(AppThemes.akainu)),
                  ),
                  DropdownMenuItem(
                    value: AppThemes.aokiji,
                    child: Text(AppThemes.toStr(AppThemes.aokiji)),
                  ),
                  DropdownMenuItem(
                    value: AppThemes.kizaru,
                    child: Text(AppThemes.toStr(AppThemes.kizaru)),
                  ),
                  DropdownMenuItem(
                    value: AppThemes.fujitora,
                    child: Text(AppThemes.toStr(AppThemes.fujitora)),
                  ),
                  DropdownMenuItem(
                    value: AppThemes.ryokugyu,
                    child: Text(AppThemes.toStr(AppThemes.ryokugyu)),
                  ),
                ],
                onChanged: (dynamic themeId) async {
                  await AdaptiveChameleonTheme.of(context).setTheme(themeId);
                  setState(() {
                    dropdownValue = themeId;
                  });
                }
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.all(20),
                      width: 100,
                      height: 120,
                      color: theme.primaryColor,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Container in primary color and primary text theme',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).primaryTextTheme.bodyText2
                          ),
                        ),
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    width: 100,
                    height: 120,
                    color: theme.colorScheme.secondary,
                    child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Container in accent color and with accent text theme',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).primaryTextTheme.bodyText2),
                        )),
                  ),
                ]
            ),

            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Elevated Button',
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.bodyText2,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24, bottom: 12),
              child: Text('Select your theme mode here:'),
            ),

            DropdownButton(
                icon: const Icon(Icons.arrow_downward),
                value: themeModeDropdownValue,
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text("Light"),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text("Dark"),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text("System"),
                  ),
                ],
                onChanged: (dynamic themeMode) async {
                  switch (themeMode) {
                    case ThemeMode.light:
                      AdaptiveChameleonTheme.of(context).changeThemeMode
                        (dark: false);
                      break;
                    case ThemeMode.dark:
                      AdaptiveChameleonTheme.of(context).changeThemeMode
                        (dark: true);
                      break;
                    case ThemeMode.system:
                      AdaptiveChameleonTheme.of(context).changeThemeMode
                        (dynamic: true);
                      break;
                  }

                  setState(() {
                    themeModeDropdownValue = themeMode;
                  });
                }
            ),

          ],
        ),
      ),
    );
  }
}
