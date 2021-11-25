import 'package:flutter/material.dart';

import '../../presentation.dart';

ThemeData get appTheme => ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: appBarColor,
        elevation: appBarElevation,
        centerTitle: appBarCenterTitle,
        iconTheme: IconThemeData(color: black),
      ),
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      colorScheme: const ColorScheme.light().copyWith(primary: primary),
    );
