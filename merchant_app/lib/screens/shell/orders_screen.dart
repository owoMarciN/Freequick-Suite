import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merchant_app/global/global.dart';
import 'package:merchant_app/widgets/orders/order_board_widget.dart';
import 'package:merchant_app/widgets/ui/unified_snackbar.dart';
import 'package:merchant_app/models/status.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // Start with all statuses visible
  final Set<String> _selectedStatuses = Set.from(workflowStatuses);

  Future<void> _updateStatus(String orderID, String newStatus) async {
    try {
      final batch = FirebaseFirestore.instance.batch();
      final orderRef =
          FirebaseFirestore.instance.collection('orders').doc(orderID);

      batch.update(orderRef, {
        'status': newStatus,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      final orderDoc = await orderRef.get();
      final userID = orderDoc.data()?['userID'] as String?;
      if (userID != null && userID.isNotEmpty) {
        final userOrderRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('orders')
            .doc(orderID);
        batch.update(userOrderRef, {
          'status': newStatus,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      await batch.commit();
      if (mounted) unifiedSnackBar(context, 'Order marked as $newStatus');
    } catch (e) {
      if (mounted) unifiedSnackBar(context, 'Update failed: $e', error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- BOARD ---
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 12, 28, 40),
            child: OrderBoardWidget(
              restaurantID: currentRestaurantUID,
              visibleStatuses: _selectedStatuses.toList(),
              onStatusChange: _updateStatus,
              readOnly: _selectedStatuses.length == 1 &&
                  _selectedStatuses.contains('Delivered'),
            ),
          ),
        ),
      ],
    );
  }
}
