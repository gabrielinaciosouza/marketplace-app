import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'data/data.dart';
import 'infra/infra.dart';
import 'presentation/presentation.dart';
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
      home: LoadingOverlay(
        child: HomePage(StreamHomePresenter(RemoteGetProducts(
            HttpAdapter(Client()),
            url: 'https://shelf-marketplace.herokuapp.com/products/'))),
      ),
    );
  }

  void setStatusBarColor(Color color) => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: color,
        ),
      );
}
