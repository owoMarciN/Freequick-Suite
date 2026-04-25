import "package:flutter/material.dart";
import "package:user_app/models/items.dart";
import "package:user_app/methods/assistant_methods.dart";
import "package:user_app/methods/favorites_methods.dart";
import 'package:shared_assets/extensions/extensions.dart';
import "package:user_app/widgets/icons/cart_icon.dart";

class ItemDetailsScreen extends StatefulWidget {
  final Items? model;
  const ItemDetailsScreen({super.key, this.model});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen>
    with SingleTickerProviderStateMixin {
  int quantity = 1;
  late final AnimationController _animController;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _incrementQuantity() {
    if (quantity < 9) setState(() => quantity++);
  }

  void _decrementQuantity() {
    if (quantity > 1) setState(() => quantity--);
  }

  double get _totalPrice {
    final base = widget.model!.hasDiscount
        ? widget.model!.discountedPrice
        : (widget.model!.price ?? 0.0);
    return base * quantity;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10nCustomer;

    if (widget.model == null) {
      return Scaffold(
        body: Center(child: Text(l10n.itemNotFound)),
      );
    }

    final item = widget.model!;
    final String displayTitle = item.title ?? l10n.unknownItem;
    final String itemID = item.itemID ?? '';
    final String menuID = item.menuID ?? '';
    final String restID = item.restaurantID ?? '';
    final bool hasImage = item.imageUrl != null && item.imageUrl!.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Stack(
        children: [
          // ── Hero image ──────────────────────────────────────────────────
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.46,
            width: double.infinity,
            child: Hero(
              tag: itemID.isNotEmpty ? itemID : displayTitle,
              child: hasImage
                  ? Image.network(
                      item.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _imageFallback(),
                    )
                  : _imageFallback(),
            ),
          ),

          // ── Gradient over image ─────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.46,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.35),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.15),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // ── Top bar ─────────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _TopBarButton(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () => Navigator.pop(context),
                  ),
                  Row(
                    children: [
                      StreamBuilder<ItemState>(
                        stream: itemStateStream(restID, menuID, itemID),
                        builder: (context, snapshot) {
                          final bool isFav = snapshot.data?.isFavorite ?? false;
                          return _TopBarButton(
                            icon: isFav
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            iconColor:
                                isFav ? Colors.redAccent : Colors.black87,
                            onTap: () {
                              if (itemID.isNotEmpty &&
                                  menuID.isNotEmpty &&
                                  restID.isNotEmpty) {
                                toggleFavorite(context, restID, menuID, itemID);
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      const _TopBarButton(
                        child: CartIconWidget(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── Discount badge ──────────────────────────────────────────────
          if (item.hasDiscount)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.46 - 52,
              left: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${item.discount!.toInt()}% OFF',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),

          // ── Content sheet ────────────────────────────────────────────────
          DraggableScrollableSheet(
            initialChildSize: 0.62,
            minChildSize: 0.62,
            maxChildSize: 0.92,
            builder: (context, scrollController) {
              return FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slideUp,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(28)),
                    ),
                    child: Column(
                      children: [
                        // Drag handle
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 6),
                          child: Container(
                            width: 36,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),

                        // Scrollable content
                        Expanded(
                          child: ListView(
                            controller: scrollController,
                            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                            children: [
                              // Title + price row
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      displayTitle,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF1A1A1A),
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (item.hasDiscount) ...[
                                        Text(
                                          '${item.price!.toStringAsFixed(2)} zł',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade400,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        Text(
                                          '${item.discountedPrice.toStringAsFixed(2)} zł',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ] else
                                        Text(
                                          '${(item.price ?? 0.0).toStringAsFixed(2)} zł',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xFF1A1A1A),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // Tags
                              if (item.tags != null &&
                                  item.tags!.isNotEmpty) ...[
                                Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: item.tags!.map((tag) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF0F4FF),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: const Color(0xFFCDD8FF)),
                                      ),
                                      child: Text(
                                        tag,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF4A6CF7),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 16),
                              ],

                              const Divider(height: 1),
                              const SizedBox(height: 16),

                              // Description
                              Text(
                                l10n.description,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item.description ?? l10n.noDescription,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  height: 1.6,
                                ),
                              ),

                              const SizedBox(height: 28),

                              // Quantity selector
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.quantity,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1A1A1A),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF7F7F7),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Row(
                                      children: [
                                        _QtyButton(
                                          icon: Icons.remove,
                                          onTap: _decrementQuantity,
                                          enabled: quantity > 1,
                                        ),
                                        SizedBox(
                                          width: 36,
                                          child: Text(
                                            '$quantity',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                              color: Color(0xFF1A1A1A),
                                            ),
                                          ),
                                        ),
                                        _QtyButton(
                                          icon: Icons.add,
                                          onTap: _incrementQuantity,
                                          enabled: quantity < 9,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 32),

                              // Add to cart button
                              GestureDetector(
                                onTap: () => addItemToCart(
                                    itemID, menuID, restID, context, quantity),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: 58,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF4A6CF7),
                                        Color(0xFF6A8BFF),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF4A6CF7)
                                            .withValues(alpha: 0.4),
                                        blurRadius: 16,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Icon(
                                          Icons.shopping_bag_rounded,
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                      ),
                                      Text(
                                        l10n.addToCartTotal(
                                            _totalPrice.toStringAsFixed(2)),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                      const SizedBox(width: 42),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _imageFallback() => Container(
        color: Colors.grey.shade200,
        child: const Center(
          child: Icon(Icons.fastfood_rounded, size: 80, color: Colors.grey),
        ),
      );
}

// ── Supporting widgets ────────────────────────────────────────────────────────

class _TopBarButton extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final Widget? child;

  const _TopBarButton({
    this.icon,
    this.iconColor,
    this.onTap,
    this.child,
  }) : assert(icon != null || child != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 12,
              spreadRadius: 0,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 4,
              spreadRadius: 0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child:
            child ?? Icon(icon, color: iconColor ?? Colors.black87, size: 20),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;

  const _QtyButton({
    required this.icon,
    required this.onTap,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: enabled ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled ? const Color(0xFF1A1A1A) : Colors.grey.shade300,
        ),
      ),
    );
  }
}
