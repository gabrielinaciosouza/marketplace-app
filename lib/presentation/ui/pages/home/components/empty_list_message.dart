import 'package:flutter/material.dart';

import '../../../../presentation.dart';

class EmptyListMessage extends StatelessWidget {
  const EmptyListMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.production_quantity_limits,
            size: bigIconSize,
          ),
          const SizedBox(
            height: spacing24,
          ),
          Text(
            R.strings.emptyList,
            style: title,
          ),
        ],
      ),
    );
  }
}
