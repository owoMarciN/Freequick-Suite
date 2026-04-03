import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rider_app/models/order_item_model.dart';

class DispatchJob {
  final String id;
  final String orderID;
  final String restaurantName;
  final String restaurantAddress;
  final String? customerName;
  final String? customerAddress;
  final double finalTotal;
  final double deliveryFee;
  final double distanceKm;
  final double riderEarnings;
  final String orderType;
  final String paymentMethod;
  final String status;
  final String? riderUID;
  final DateTime? createdAt;
  final DateTime? expiresAt;
  final List<OrderItem> items;
  final bool collectPayment;

  const DispatchJob({
    required this.id,
    required this.orderID,
    this.restaurantName = '',
    this.restaurantAddress = '',
    this.customerName,
    this.customerAddress,
    this.finalTotal = 0.0,
    this.deliveryFee = 0.0,
    this.distanceKm = 0.0,
    this.riderEarnings = 0.0,
    this.orderType = 'delivery',
    this.paymentMethod = 'cash',
    this.status = 'pending',
    this.riderUID,
    this.createdAt,
    this.expiresAt,
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
      finalTotal: (d['finalTotal'] as num?)?.toDouble() ?? 0.0,
      deliveryFee: (d['deliveryFee'] as num?)?.toDouble() ?? 0.0,
      distanceKm: (d['distanceKm'] as num?)?.toDouble() ?? 0.0,
      riderEarnings: (d['riderEarnings'] as num?)?.toDouble() ?? 0.0,
      orderType: d['orderType'] as String? ?? 'delivery',
      paymentMethod: d['paymentMethod'] as String? ?? 'cash',
      status: d['status'] as String? ?? 'pending',
      riderUID: d['riderUID'] as String?,
      createdAt: d['createdAt'] != null ? (d['createdAt'] as Timestamp).toDate() : null,
      expiresAt: d['expiresAt'] != null ? (d['expiresAt'] as Timestamp).toDate() : null,
      collectPayment: d['collectPayment'] as bool? ?? false,
      items: (d['items'] as List<dynamic>? ?? [])
          .map((e) => OrderItem.fromMap((e as Map).cast<String, dynamic>()))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'DispatchJob(id: $id, orderID: $orderID, restaurantName: $restaurantName, status: $status, finalTotal: $finalTotal, distance: $distanceKm km)';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderID': orderID,
      'restaurantName': restaurantName,
      'restaurantAddress': restaurantAddress,
      'customerName': customerName,
      'customerAddress': customerAddress,
      'finalTotal': finalTotal,
      'deliveryFee': deliveryFee,
      'distanceKm': distanceKm,
      'riderEarnings': riderEarnings,
      'orderType': orderType,
      'paymentMethod': paymentMethod,
      'status': status,
      'items': items,
      'riderUID': riderUID,
      'createdAt': createdAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'collectPayment': collectPayment,
      // 'items': items.map((e) => e.toMap()).toList(), 
    };
  }
}