import 'package:flutter/material.dart';

import '../ui.dart';

class RetryButton extends StatelessWidget {
  const RetryButton({
    Key? key,
    required this.onRetry,
  }) : super(key: key);

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: spacing64,
      width: width / widthButtonDivisor,
      child: OutlinedButton(
        onPressed: onRetry,
        child: Text(
          R.strings.retry,
          style: outlinedButton,
        ),
      ),
    );
  }
}
