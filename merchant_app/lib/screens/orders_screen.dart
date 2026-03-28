import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merchant_app/extensions/extensions_import.dart';
import 'package:merchant_app/global/global.dart';
import 'package:merchant_app/widgets/unified_snackbar.dart';
import 'package:merchant_app/widgets/order_table_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  //  Tab controller: Active / Delivered
  late final TabController _tabs;

  static const List<String> _activeStatuses = [
    'Pending',
    'In Progress',
    'Ready',
    'Out for Delivery'
  ];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  //  Status update

  Future<void> _updateStatus(String orderID, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderID)
          .update({
        'status': newStatus,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Mirror to user's sub-collection
      final orderDoc = await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderID)
          .get();
      final userID = orderDoc.data()?['userID'] as String?;
      if (userID != null && userID.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('orders')
            .doc(orderID)
            .update({
          'status': newStatus,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      if (mounted) unifiedSnackBar(context, 'Status updated to $newStatus');
    } catch (e) {
      if (mounted) {
        unifiedSnackBar(context, 'Failed to update: $e', error: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        //  Tab bar
        Container(
          color: colorScheme.surface,
          child: TabBar(
            controller: _tabs,
            labelColor: brandColors.navy,
            unselectedLabelColor: brandColors.muted,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            indicatorColor: brandColors.navy,
            indicatorWeight: 2,
            tabs: const [
              Tab(text: 'Active'),
              Tab(text: 'Delivered'),
            ],
          ),
        ),

        //  Tab views
        Expanded(
          child: TabBarView(
            controller: _tabs,
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(28, 24, 28, 40),
                child: OrderTableWidget(
                  restaurantID: restaurantUid,
                  statuses: _activeStatuses,
                  onStatusChange: _updateStatus,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(28, 24, 28, 40),
                child: OrderTableWidget(
                  restaurantID: restaurantUid,
                  statuses: const ['Delivered'],
                  readOnly: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
