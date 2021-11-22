import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main/main.dart';
import 'ui/ui.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(scaffoldBackgroundColor);

    return MaterialApp(
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      title: R.strings.appTitle,
      theme: appTheme,
      builder: builder,
      home: homePage,
    );
  }

  void setStatusBarColor(Color color) => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: color,
        ),
      );
}
