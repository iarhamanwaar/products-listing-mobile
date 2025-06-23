import 'package:bloc/bloc.dart';

import 'package:product_listing_app/products/domain/repositories/product_repository.dart';
import 'package:product_listing_app/products/presentation/bloc/products_event.dart';
import 'package:product_listing_app/products/presentation/bloc/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(const ProductsInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<SearchProducts>(_onSearchProducts);
    on<RefreshProducts>(_onRefreshProducts);
  }

  final ProductRepository _productRepository;

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      emit(const ProductsLoading());
      final products = await _productRepository.getProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductsState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProductsLoaded) {
      if (event.query.isEmpty) {
        emit(ProductsLoaded(currentState.products));
        return;
      }

      final filteredProducts = currentState.products
          .where(
            (product) =>
                product.name
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                (product.description?.toLowerCase() ?? '')
                    .contains(event.query.toLowerCase()),
          )
          .toList();

      emit(ProductsLoaded(filteredProducts));
    }
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      final products = await _productRepository.getProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      // Keep the current state on refresh error
      if (state is! ProductsLoaded) {
        emit(ProductsError(e.toString()));
      }
    }
  }
}
