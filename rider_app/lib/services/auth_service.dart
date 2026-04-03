// lib/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  //  Rider profile
  // Field names MUST match RiderModel.fromDoc() in rider_provider.dart.
  // Only creates the doc if it doesn't already exist.

  Future<void> ensureRiderProfile({
    required String name,
    required String phone,
    required String vehicleType,
  }) async {
    final uid = currentUser!.uid;

    await FirebaseFirestore.instance.collection('riders').doc(uid).set({
      'name': name,
      'phone': phone,
      'vehicleType': vehicleType,
      'isOnline': true,
      'hasActiveOrder': false,
      'currentOrderID': null,
      'totalDeliveries': 0,
      'totalEarnings': 0,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  //  Sign out

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
