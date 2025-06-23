import 'package:flutter/material.dart';

import 'package:product_listing_app/products/domain/entities/product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    required this.product,
    required this.isGridView,
    super.key,
  });

  final Product product;
  final bool isGridView;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 1.02,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
      if (isHovered) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget buildContent() {
      if (widget.isGridView) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              child: AspectRatio(
                aspectRatio: 1,
                child: _buildImage(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPrice(theme),
                    const SizedBox(height: 4),
                    _buildName(theme),
                    if (widget.product.description != null) ...[
                      const SizedBox(height: 4),
                      Expanded(
                        child: _buildDescription(theme),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
      } else {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(24)),
              child: SizedBox(
                width: 120,
                height: 120,
                child: _buildImage(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPrice(theme),
                    const SizedBox(height: 4),
                    _buildName(theme),
                    if (widget.product.description != null) ...[
                      const SizedBox(height: 4),
                      _buildDescription(theme),
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
      }
    }

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTapDown: (_) => _onHover(true),
        onTapUp: (_) => _onHover(false),
        onTapCancel: () => _onHover(false),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: theme.colorScheme.shadow.withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: theme.colorScheme.shadow.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          widget.product.imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.5),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                size: 32,
                color:
                    Theme.of(context).colorScheme.error.withValues(alpha: 0.5),
              ),
            );
          },
        ),
        if (_isHovered)
          const ColoredBox(
            color: Colors.black12,
            child: SizedBox(),
          ),
      ],
    );
  }

  Widget _buildName(ThemeData theme) {
    return Text(
      widget.product.name,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: -0.5,
        height: 1.2,
      ),
      maxLines: widget.isGridView ? 1 : 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPrice(ThemeData theme) {
    return Text(
      '\$${widget.product.price.toStringAsFixed(2)}',
      style: theme.textTheme.titleLarge?.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        height: 1.2,
      ),
    );
  }

  Widget _buildDescription(ThemeData theme) {
    return Text(
      widget.product.description!,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        letterSpacing: -0.2,
        height: 1.2,
      ),
      maxLines: widget.isGridView ? 2 : 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
