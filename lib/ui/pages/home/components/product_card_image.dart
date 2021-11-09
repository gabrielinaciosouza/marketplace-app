import 'package:flutter/material.dart';

import '../../../ui.dart';

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
            shape: BoxShape.circle,
            child: Container(
              height: constraints.maxHeight / productImageDivisor,
              width: constraints.maxHeight / productImageDivisor,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(spacing24),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
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
        );
      },
    );
  }
}
