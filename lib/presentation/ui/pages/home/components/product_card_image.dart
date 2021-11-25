import 'package:flutter/material.dart';

import '../../../../presentation.dart';

class ProductCardImage extends StatelessWidget {
  const ProductCardImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Align(
          alignment: Alignment.topCenter,
          child: PhysicalModel(
            color: shadowColor,
            elevation: productImageElevation,
            borderRadius: BorderRadius.circular(borderRadius16),
            child: Container(
              height: constraints.maxHeight / productImageDivisor,
              width: constraints.maxHeight / productImageDivisor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius16),
                color: white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(spacing8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius16),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stactrace) {
                      return Icon(
                        Icons.image_not_supported,
                        color: primary,
                        size: constraints.maxHeight / iconPlaceHolderDivisor,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
