import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../presentation.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex55,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final products = state.selectedCategory?.products ?? [];
          final width = MediaQuery.of(context).size.width;
          if (state.isLoadingProductsByCategoryId) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (products.isEmpty) {
            return const EmptyListMessage();
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.only(
                left: width / spacing8, right: width / spacing8),
            itemCount: products.length,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: width / spacing8,
              );
            },
            itemBuilder: (context, index) {
              final product = products[index];

              return Stack(
                alignment: Alignment.center,
                children: [
                  ProductCard(product: product),
                  ProductCardImage(
                    imageUrl: product.imageUrl,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
