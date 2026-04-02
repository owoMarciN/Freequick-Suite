//  Order item
class OrderItem {
  final String name;
  final int quantity;
  final double price;
  final double originalPrice;
  final int discount;        
  final String? options;

  const OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
    this.originalPrice = 0.0,
    this.discount = 0,
    this.options,
  });

  factory OrderItem.fromMap(Map<String, dynamic> m) => OrderItem(
        name: m['name'] as String? ?? '',
        quantity: (m['quantity'] as num?)?.toInt() ?? 1,
        price: (m['price'] as num?)?.toDouble() ?? 0.0,
        originalPrice: (m['originalPrice'] as num?)?.toDouble() ?? 0.0,
        discount: (m['discount'] as num?)?.toInt() ?? 0,
        options: m['options'] as String?,
      );

  String get discountLabel => discount > 0 ? '$discount% OFF' : '';
  
  bool get hasDiscount => discount > 0;
}