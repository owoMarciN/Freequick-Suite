import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rider_app/models/delivery_model.dart';

class DispatchJob {
  final String id;
  final String orderID;
  final String restaurantName;
  final String restaurantAddress;
  final String? customerName;
  final String? customerAddress;
  final double totalAmount;
  final double deliveryFee;
  final String orderType;
  final String paymentMethod;
  final List<OrderItem> items;
  final bool collectPayment;

  const DispatchJob({
    required this.id,
    required this.orderID,
    this.restaurantName = '',
    this.restaurantAddress = '',
    this.customerName,
    this.customerAddress,
    this.totalAmount = 0,
    this.deliveryFee = 0,
    this.orderType = 'delivery',
    this.paymentMethod = 'cash',
    this.items = const [],
    this.collectPayment = false,
  });

  factory DispatchJob.fromDoc(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>? ?? {};
    return DispatchJob(
      id: doc.id,
      orderID: d['orderID'] as String? ?? '',
      restaurantName: d['restaurantName'] as String? ?? '',
      restaurantAddress: d['restaurantAddress'] as String? ?? '',
      customerName: d['customerName'] as String?,
      customerAddress: d['customerAddress'] as String?,
      totalAmount: (d['totalAmount'] as num?)?.toDouble() ?? 0,
      deliveryFee: (d['deliveryFee'] as num?)?.toDouble() ?? 0,
      orderType: d['orderType'] as String? ?? 'delivery',
      paymentMethod: d['paymentMethod'] as String? ?? 'cash',
      collectPayment: d['collectPayment'] as bool? ?? false,
      items: (d['items'] as List<dynamic>? ?? [])
          .map((e) => OrderItem.fromMap((e as Map).cast<String, dynamic>()))
          .toList(),
    );
  }

  String get storeName => restaurantName;
  String? get storeAddress =>
      restaurantAddress.isEmpty ? null : restaurantAddress;
}