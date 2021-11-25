import 'package:flutter/material.dart';

import '../../../../presentation.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductViewModel product;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight / productCardDivisor,
          width: constraints.maxHeight / productCardDivisor,
          padding: const EdgeInsets.all(spacing16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius16),
          ),
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                Text(
                  product.name,
                  maxLines: maxLines2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: title,
                ),
                const SizedBox(
                  height: spacing8,
                ),
                Text(
                  product.price,
                  textAlign: TextAlign.center,
                  style: price,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
