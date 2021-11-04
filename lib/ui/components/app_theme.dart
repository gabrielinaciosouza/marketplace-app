import 'package:flutter/material.dart';

import '../ui.dart';

ThemeData get appTheme => ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
        elevation: appBarElevation,
        centerTitle: appBarCenterTitle,
        iconTheme: IconThemeData(color: black),
      ),
      scaffoldBackgroundColor: scaffoldBackgroundColor,
    );
