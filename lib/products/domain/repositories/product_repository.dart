import 'package:product_listing_app/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}
