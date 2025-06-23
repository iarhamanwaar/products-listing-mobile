import 'package:flutter/material.dart';

import 'package:product_listing_app/products/domain/entities/product.dart';

class ProductsViewModel extends ChangeNotifier {
  ProductsViewModel() {
    _searchController.addListener(_onSearchChanged);
  }

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  bool _isGridView = true;
  bool get isGridView => _isGridView;

  bool _isSearchVisible = false;
  bool get isSearchVisible => _isSearchVisible;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  List<Product> filterProducts(List<Product> products) {
    if (_searchQuery.isEmpty) return products;

    return products
        .where(
          (product) =>
              product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              (product.description?.toLowerCase() ?? '')
                  .contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  void toggleSearchVisibility() {
    _isSearchVisible = !_isSearchVisible;
    if (!_isSearchVisible) {
      _searchController.clear();
    }
    notifyListeners();
  }

  void toggleViewMode() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  void _onSearchChanged() {
    _searchQuery = _searchController.text;
    notifyListeners();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }
}
