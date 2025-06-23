import 'package:flutter/material.dart';

import 'package:product_listing_app/products/domain/entities/product.dart';
import 'package:product_listing_app/products/presentation/widgets/product_card.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({
    required this.products,
    required this.animation,
    super.key,
  });

  final List<Product> products;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = switch (width) {
          >= 1200 => 4, // Extra large screens
          >= 800 => 3, // Large screens/tablets
          >= 400 => 2, // Phones (including iPhone Pro Max)
          _ => 1, // Very small devices
        };

        return FadeTransition(
          opacity: animation,
          child: GridView.builder(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 32,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85,
              mainAxisExtent: 320,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Hero(
                tag: 'product-${products[index].id}',
                child: ProductCard(
                  product: products[index],
                  isGridView: true,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
