import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/l10n/l10n.dart';
import 'package:product_listing_app/products/data/repositories/mock_product_repository.dart';
import 'package:product_listing_app/products/presentation/bloc/products_bloc.dart';
import 'package:product_listing_app/products/presentation/bloc/products_event.dart';
import 'package:product_listing_app/products/presentation/bloc/products_state.dart';
import 'package:product_listing_app/products/presentation/view_models/products_view_model.dart';
import 'package:product_listing_app/products/presentation/widgets/products_grid_view.dart';
import 'package:product_listing_app/products/presentation/widgets/products_list_view.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(
        productRepository: MockProductRepository(),
      )..add(const LoadProducts()),
      child: ChangeNotifierProvider(
        create: (context) => ProductsViewModel(),
        child: const ProductsView(),
      ),
    );
  }
}

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final viewModel = context.watch<ProductsViewModel>();

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const SizedBox(height: 0),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        scrolledUnderElevation: 0,
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: viewModel.isSearchVisible
              ? TextField(
                  controller: viewModel.searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      letterSpacing: -0.5,
                    ),
                  ),
                  style: theme.textTheme.titleMedium?.copyWith(
                    letterSpacing: -0.5,
                  ),
                  autofocus: true,
                )
              : Text(
                  l10n.productsAppBarTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              viewModel.isSearchVisible ? Icons.close : Icons.search,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: viewModel.toggleSearchVisibility,
          ),
          IconButton(
            icon: Icon(
              viewModel.isGridView ? Icons.view_list : Icons.grid_view,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () {
              viewModel.toggleViewMode();
              _animationController.forward(from: 0);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsInitial || state is ProductsLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: theme.colorScheme.primary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading products...',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is ProductsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: theme.colorScheme.error.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.errorPrefix(state.message),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.error,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () {
                      context.read<ProductsBloc>().add(const RefreshProducts());
                    },
                    icon: const Icon(Icons.refresh),
                    label: Text(l10n.tryAgain),
                  ),
                ],
              ),
            );
          }

          if (state is ProductsLoaded) {
            final filteredProducts = viewModel.filterProducts(state.products);

            if (filteredProducts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off_outlined,
                      size: 48,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No products found',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              );
            }

            _animationController.forward();

            return RefreshIndicator(
              onRefresh: () async {
                _animationController.reset();
                context.read<ProductsBloc>().add(const RefreshProducts());
              },
              child: viewModel.isGridView
                  ? ProductsGridView(
                      products: filteredProducts,
                      animation: _animation,
                    )
                  : ProductsListView(
                      products: filteredProducts,
                      animation: _animation,
                    ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
