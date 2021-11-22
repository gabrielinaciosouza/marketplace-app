import 'package:flutter/material.dart';

import '../../ui/ui.dart';
import '../main.dart';

Widget builder(BuildContext context, Widget? child) =>
    LoadingOverlay(child: child ?? const SizedBox());

final homePage = HomePage(homePresenter);
