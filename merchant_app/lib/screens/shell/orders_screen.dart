import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merchant_app/extensions/extensions_import.dart';
import 'package:merchant_app/global/global.dart';
import 'package:merchant_app/widgets/ui/unified_snackbar.dart';
import 'package:merchant_app/widgets/designs/order_table_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // The available statuses defined in your Cloud Functions
  final List<String> _workflowStatuses = [
    'Pending',
    'In Progress',
    'Ready',
    'Delivered'
  ];

  // Users can toggle these to filter the view
  final List<String> _selectedFilters = ['Pending', 'In Progress', 'Ready'];

  Future<void> _updateStatus(String orderID, String newStatus) async {
    try {
      final batch = FirebaseFirestore.instance.batch();
      final orderRef =
          FirebaseFirestore.instance.collection('orders').doc(orderID);

      // 1. Update main order
      batch.update(orderRef, {
        'status': newStatus,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // 2. Fetch to get userID for mirroring (required by your backend logic)
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
    final brandColors = Theme.of(context).extension<BrandColors>()!;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          color: Theme.of(context).colorScheme.surface,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _workflowStatuses.map((status) {
                final isSelected = _selectedFilters.contains(status);
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(status),
                    selected: isSelected,
                    selectedColor: brandColors.navy!.withValues(alpha: 0.2),
                    checkmarkColor: brandColors.navy,
                    labelStyle: TextStyle(
                      color: isSelected ? brandColors.navy : brandColors.muted,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (bool value) {
                      setState(() {
                        value
                            ? _selectedFilters.add(status)
                            : _selectedFilters.remove(status);
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        // Unified Table View
        Expanded(
          child: _selectedFilters.isEmpty
              ? const Center(child: Text("Select a status to view orders"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(28, 12, 28, 40),
                  child: OrderTableWidget(
                    restaurantID: currentRestaurantUID,
                    filterStatuses: _selectedFilters,
                    onStatusChange: _updateStatus,
                    workflowStatuses: _workflowStatuses,
                    // "Delivered" is usually read-only in your flow,
                    // but this allows changes if it's not the only status selected.
                    readOnly: _selectedFilters.length == 1 &&
                        _selectedFilters.contains('Delivered'),
                  ),
                ),
        ),
      ],
    );
  }
}
