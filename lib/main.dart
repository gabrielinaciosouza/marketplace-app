import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'main/main.dart';
import 'presentation/presentation.dart';

Future<void> main() async {
  await Hive.initFlutter();
  final homePage = await makeHomePage;

  runApp(App(homePage: homePage));
}

class App extends StatelessWidget {
  const App({Key? key, required this.homePage}) : super(key: key);

  final HomePage homePage;
  @override
  Widget build(BuildContext context) {
    setStatusBarColor(scaffoldBackgroundColor);

    return MaterialApp(
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      title: R.strings.appTitle,
      theme: appTheme,
      home: homePage,
    );
  }

  void setStatusBarColor(Color color) => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: color,
        ),
      );
}
