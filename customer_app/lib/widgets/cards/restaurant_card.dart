import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_assets/extensions/extensions.dart';
import 'package:user_app/models/items.dart';
import 'package:user_app/screens/items/item_details_screen.dart';
import 'package:user_app/screens/menus/menus_screen.dart';
import 'package:user_app/models/restaurants.dart';
import 'package:user_app/methods/favorites_methods.dart';
import 'package:user_app/widgets/ratings/rating_sheet.dart';

class RestaurantCard extends StatelessWidget {
  final String restaurantID;
  final String restaurantName;

  const RestaurantCard({
    required this.restaurantID,
    required this.restaurantName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('restaurants')
          .doc(restaurantID)
          .snapshots(),
      builder: (context, restSnap) {
        if (!restSnap.hasData) return const SizedBox.shrink();
        
        // Use the model to handle data mapping
        final Restaurants restaurant = Restaurants.fromJson(
          restSnap.data!.data() as Map<String, dynamic>
        );

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEEEEEE)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RestaurantHeader(
                model: restaurant,
                totalRatings: (restSnap.data!.data() as Map<String, dynamic>)['totalRatings'] ?? 0,
              ),
              _ItemsScroller(restaurantID: restaurantID),
            ],
          ),
        );
      },
    );
  }
}

class _RestaurantHeader extends StatelessWidget {
  final Restaurants model;
  final int totalRatings;

  const _RestaurantHeader({
    required this.model,
    required this.totalRatings,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MenusScreen(model: model),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              clipBehavior: Clip.antiAlias,
              child: (model.logoUrl?.isNotEmpty == true)
                  ? Image.network(model.logoUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _logoFallback())
                  : _logoFallback(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.delivery_dining_rounded,
                          size: 13, color: Colors.grey.shade400),
                      const SizedBox(width: 3),
                      Text(
                        context.l10nCustomer.deliveryTime("20", "35"),
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade500),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.circle, size: 4, color: Colors.grey.shade400),
                      const SizedBox(width: 8),
                      Icon(Icons.storefront_rounded,
                          size: 13, color: Colors.grey.shade400),
                      const SizedBox(width: 3),
                      Text(
                        context.l10nCustomer.freeDelivery,
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => _openRatingSheet(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: (model.avgRating ?? 0) >= 4
                      ? const Color(0xFF00C48C).withValues(alpha: 0.1)
                      : (model.avgRating ?? 0) >= 3
                          ? Colors.amber.withValues(alpha: 0.1)
                          : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: (model.avgRating ?? 0) >= 4
                        ? const Color(0xFF00C48C).withValues(alpha: 0.3)
                        : (model.avgRating ?? 0) >= 3
                            ? Colors.amber.withValues(alpha: 0.3)
                            : Colors.grey.shade200,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: (model.avgRating ?? 0) >= 4
                          ? const Color(0xFF00C48C)
                          : (model.avgRating ?? 0) >= 3
                              ? Colors.amber.shade700
                              : Colors.grey.shade400,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      totalRatings == 0
                          ? context.l10nCustomer.newStatus
                          : model.avgRating!.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: (model.avgRating ?? 0) >= 4
                            ? const Color(0xFF00C48C)
                            : (model.avgRating ?? 0) >= 3
                                ? Colors.amber.shade700
                                : Colors.grey.shade500,
                      ),
                    ),
                    if (totalRatings > 0) ...[
                      const SizedBox(width: 3),
                      Text(
                        '($totalRatings)',
                        style: TextStyle(
                            fontSize: 10, color: Colors.grey.shade400),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openRatingSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RatingSheet(
        restaurantID: model.restaurantID!,
        restaurantName: model.name!,
        logoUrl: model.logoUrl!,
      ),
    );
  }

  Widget _logoFallback() => Container(
        color: Colors.grey.shade100,
        child: Icon(Icons.restaurant_rounded,
            size: 26, color: Colors.grey.shade300),
      );
}

class _ItemsScroller extends StatelessWidget {
  final String restaurantID;
  const _ItemsScroller({required this.restaurantID});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('restaurants')
          .doc(restaurantID)
          .collection('menus')
          .limit(1)
          .snapshots(),
      builder: (context, menuSnap) {
        if (!menuSnap.hasData || menuSnap.data!.docs.isEmpty) {
          return const SizedBox.shrink();
        }
        final menuID = menuSnap.data!.docs.first.id;

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('restaurants')
              .doc(restaurantID)
              .collection('menus')
              .doc(menuID)
              .collection('items')
              .limit(10)
              .snapshots(),
          builder: (context, itemSnap) {
            if (!itemSnap.hasData || itemSnap.data!.docs.isEmpty) {
              return const SizedBox.shrink();
            }

            final docs = itemSnap.data!.docs;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 1, color: Colors.grey.shade100),
                SizedBox(
                  height: 190,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      Items item =
                          Items.fromJson(doc.data() as Map<String, dynamic>);
                      item.itemID = doc.id;
                      item.menuID = menuID;
                      item.restaurantID = restaurantID;
                      return _ItemTile(item: item);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _ItemTile extends StatelessWidget {
  final Items item;
  const _ItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ItemDetailsScreen(model: item)),
      ),
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: SizedBox(
                    height: 90,
                    width: double.infinity,
                    child: (item.imageUrl?.isNotEmpty == true)
                        ? Image.network(item.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _imgFallback())
                        : _imgFallback(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 6, 8, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      if (item.hasDiscount) ...[
                        Text(
                          context.l10nCustomer.currencyFormat(item.price!.toStringAsFixed(2)),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade400,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          context.l10nCustomer.currencyFormat(item.discountedPrice.toStringAsFixed(2)),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.redAccent,
                          ),
                        ),
                      ] else
                        Text(
                          context.l10nCustomer.currencyFormat(item.price?.toStringAsFixed(2) ?? '0.00'),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.redAccent,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (item.hasDiscount)
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    context.l10nCustomer.discountPercent(item.discount!.toInt()),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            Positioned(
              top: 4,
              right: 4,
              child: StreamBuilder<bool>(
                stream: isFavoriteStream(item.itemID ?? ''),
                builder: (context, snap) {
                  final bool fav = snap.data ?? false;
                  return GestureDetector(
                    onTap: () {
                      if (item.itemID != null &&
                          item.menuID != null &&
                          item.restaurantID != null) {
                        toggleFavorite(context, 
                            item.restaurantID!, item.menuID!, item.itemID!);
                      }
                    },
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        fav
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 14,
                        color: fav ? Colors.redAccent : Colors.grey.shade400,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imgFallback() => Container(
        color: Colors.grey.shade100,
        child:
            Icon(Icons.fastfood_rounded, color: Colors.grey.shade300, size: 28),
      );
}