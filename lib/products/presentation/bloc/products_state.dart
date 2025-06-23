import 'package:equatable/equatable.dart';

import 'package:product_listing_app/products/domain/entities/product.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

class ProductsLoaded extends ProductsState {
  const ProductsLoaded(this.products);

  final List<Product> products;

  @override
  List<Object> get props => [products];
}

class ProductsError extends ProductsState {
  const ProductsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
