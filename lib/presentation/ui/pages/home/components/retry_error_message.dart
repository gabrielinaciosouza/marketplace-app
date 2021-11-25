import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../presentation.dart';

class RetryErrorMessage extends StatelessWidget {
  const RetryErrorMessage({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<HomeCubit>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: bigIconSize,
            color: Colors.red,
          ),
          const SizedBox(
            height: spacing8,
          ),
          Text(
            errorMessage,
            style: title,
          ),
          const SizedBox(
            height: spacing16,
          ),
          RetryButton(
            onRetry: cubit.loadProducts,
          )
        ],
      ),
    );
  }
}
