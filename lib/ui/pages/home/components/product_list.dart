import 'package:flutter/material.dart';

import '../../../ui.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePresenter _homePresenter =
        Supplier.of<HomePresenter>(context).presenter;
    final width = MediaQuery.of(context).size.width;
    return Flexible(
      flex: flex55,
      child: StreamBuilder<List<ProductViewModel>>(
        stream: _homePresenter.productsStream,
        builder: (context, snapshot) {
          final products = snapshot.data ?? [];
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
