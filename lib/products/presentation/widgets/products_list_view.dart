import 'package:flutter/material.dart';

import 'package:product_listing_app/products/domain/entities/product.dart';
import 'package:product_listing_app/products/presentation/widgets/product_card.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({
    required this.products,
    required this.animation,
    super.key,
  });

  final List<Product> products;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 32,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Hero(
              tag: 'product-${products[index].id}',
              child: ProductCard(
                product: products[index],
                isGridView: false,
              ),
            ),
          );
        },
      ),
    );
  }
}
