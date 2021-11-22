import 'package:flutter/material.dart';
import 'package:marketplace_app/main/main.dart';
import 'package:marketplace_app/ui/ui.dart';

Widget buildApp(Widget widget) => MaterialApp(
      builder: builder,
      home: widget,
      theme: appTheme,
    );
