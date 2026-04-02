import 'package:cloud_firestore/cloud_firestore.dart';

class RiderModel {
  final String uid;
  final String name;
  final String phone;
  final String photoUrl;
  final String vehicleType;
  final bool isOnline;
  final bool hasActiveOrder;
  final String? currentOrderID;
  final int totalDeliveries;
  final double totalEarnings;
  final double rating;

  const RiderModel({
    required this.uid,
    required this.name,
    this.phone = '',
    this.photoUrl = '',
    this.vehicleType = 'SCOOTER',
    this.isOnline = false,
    this.hasActiveOrder = false,
    this.currentOrderID,
    this.totalDeliveries = 0,
    this.totalEarnings = 0.0,
    this.rating = 5.0,
  });

  factory RiderModel.fromDoc(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>? ?? {};
    return RiderModel(
      uid: doc.id,
      name: d['name'] as String? ?? 'Rider',
      phone: d['phone'] as String? ?? '',
      photoUrl: d['photoUrl'] as String? ?? '',
      vehicleType: d['vehicleType'] as String? ?? 'SCOOTER',
      isOnline: d['isOnline'] as bool? ?? false,
      hasActiveOrder: d['hasActiveOrder'] as bool? ?? false,
      currentOrderID: d['currentOrderID'] as String?,
      totalDeliveries: (d['totalDeliveries'] as num?)?.toInt() ?? 0,
      totalEarnings: (d['totalEarnings'] as num?)?.toDouble() ?? 0.0,
      rating: (d['rating'] as num?)?.toDouble() ?? 5.0,
    );
  }
}
