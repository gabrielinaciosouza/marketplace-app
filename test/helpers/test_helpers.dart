import 'package:flutter/material.dart';
import 'package:marketplace_app/ui/ui.dart';

Widget buildApp(Widget widget) => MaterialApp(
      home: LoadingOverlay(child: widget),
      theme: appTheme,
    );
