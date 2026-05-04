// lib/widgets/orders/order_board_widget.dart
//
// Merchant app Kanban board for managing orders.
// Status flow (from AppConstants, synced with Cloud Functions):
//   Pending → In Progress → Ready → Delivered
//
// Two ways to change status:
//   1. Drag a card and drop it into another column
//   2. Tap the ⋮ menu on a card and pick a status from the dropdown

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_assets/extensions/extensions.dart';
import 'package:shared_assets/widgets/ui/progress_bar.dart';

// Import AppConstants from wherever it lives in shared_assets or merchant_app
// adjust the import path to match your project structure
import 'package:shared_assets/utils/app_constants.dart';

class OrderBoardWidget extends StatelessWidget {
  final String? restaurantID;
  final int? limit;
  final bool readOnly;
  final double? height;
  final List<String> visibleStatuses;
  final Future<void> Function(String orderID, String newStatus)? onStatusChange;

  OrderBoardWidget({
    super.key,
    required this.restaurantID,
    required this.visibleStatuses,
    this.limit,
    this.readOnly = false,
    this.height,
    this.onStatusChange,
  }) : assert(readOnly || onStatusChange != null,
            'onStatusChange is required when readOnly is false');

  final ScrollController _bodyScrollController = ScrollController();

  // The full ordered pipeline — used for dropdown options
  static const List<String> _pipeline = [
    AppConstants.statusPending,
    AppConstants.statusInProgress,
    AppConstants.statusReady,
    AppConstants.statusDelivered,
  ];

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>()!;
    final colorScheme = Theme.of(context).colorScheme;

    if (visibleStatuses.isEmpty) {
      return Center(
        child: Text(
          'Select a status above to view orders.',
          style: TextStyle(color: brandColors.muted),
        ),
      );
    }

    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection(AppConstants.colOrders)
        .where('restaurantID', isEqualTo: restaurantID)
        .where(AppConstants.fieldStatus, whereIn: visibleStatuses)
        .orderBy('orderTime', descending: true);

    if (limit != null) query = query.limit(limit!);

    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: circularProgress());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading orders',
              style: TextStyle(color: brandColors.muted),
            ),
          );
        }

        final docs = snapshot.data?.docs ?? [];
        final Map<String, List<QueryDocumentSnapshot>> grouped = {
          for (final s in visibleStatuses) s: [],
        };
        for (final doc in docs) {
          final data = doc.data() as Map<String, dynamic>;
          final status = data[AppConstants.fieldStatus]?.toString() ?? AppConstants.statusPending;
          grouped[status]?.add(doc);
        }

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Scrollbar(
              controller: _bodyScrollController,
              thumbVisibility: true,
              trackVisibility: true,
              child: SingleChildScrollView(
                controller: _bodyScrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(
                    bottom: 20, left: 16, right: 16, top: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: visibleStatuses.map((status) {
                    return SizedBox(
                      width: 320,
                      child: _BoardColumn(
                        status: status,
                        orders: grouped[status]!,
                        brandColors: brandColors,
                        readOnly: readOnly,
                        pipeline: _pipeline,
                        onStatusChange: onStatusChange,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Board column ──────────────────────────────────────────────────────────────

class _BoardColumn extends StatelessWidget {
  final String status;
  final List<QueryDocumentSnapshot> orders;
  final BrandColors brandColors;
  final bool readOnly;
  final List<String> pipeline;
  final Future<void> Function(String, String)? onStatusChange;

  const _BoardColumn({
    required this.status,
    required this.orders,
    required this.brandColors,
    required this.readOnly,
    required this.pipeline,
    this.onStatusChange,
  });

  Color _statusColor(BuildContext context, String s) {
    final cs = Theme.of(context).colorScheme;
    return switch (s) {
      AppConstants.statusPending => const Color(0xFFD97706),
      AppConstants.statusInProgress => Colors.redAccent,
      AppConstants.statusReady => cs.primary,
      AppConstants.statusDelivered => const Color(0xFF00C48C),
      _ => Colors.grey,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = _statusColor(context, status);

    return DragTarget<String>(
      onWillAcceptWithDetails: (details) => !readOnly && details.data != status,
      onAcceptWithDetails: (details) {
        onStatusChange?.call(details.data, status);
      },
      builder: (context, candidateData, _) {
        final isHovered = candidateData.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: isHovered
                ? color.withValues(alpha: 0.08)
                : colorScheme.surface.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered ? color : colorScheme.surfaceBright,
              width: isHovered ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              // Column header
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 0.8,
                          color: color,
                        ),
                      ),
                    ),
                    Badge(
                      label: Text(
                        orders.length.toString(),
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: color,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: colorScheme.surfaceBright),

              // Cards
              Expanded(
                child: orders.isEmpty
                    ? Center(
                        child: Text(
                          'No orders',
                          style: TextStyle(
                              color: brandColors.muted, fontSize: 12),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final doc = orders[index];
                          final card = _OrderCard(
                            doc: doc,
                            brandColors: brandColors,
                            currentStatus: status,
                            pipeline: pipeline,
                            readOnly: readOnly,
                            onStatusChange: onStatusChange,
                          );

                          if (readOnly) return card;

                          return Draggable<String>(
                            data: doc.id,
                            feedback: Material(
                              color: Colors.transparent,
                              child: SizedBox(width: 290, child: card),
                            ),
                            childWhenDragging:
                                Opacity(opacity: 0.35, child: card),
                            child: card,
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Order card ────────────────────────────────────────────────────────────────

class _OrderCard extends StatelessWidget {
  final QueryDocumentSnapshot doc;
  final BrandColors brandColors;
  final String currentStatus;
  final List<String> pipeline;
  final bool readOnly;
  final Future<void> Function(String, String)? onStatusChange;

  const _OrderCard({
    required this.doc,
    required this.brandColors,
    required this.currentStatus,
    required this.pipeline,
    required this.readOnly,
    this.onStatusChange,
  });

  List<String> _otherStatuses() =>
      pipeline.where((s) => s != currentStatus).toList();

  Color _statusColor(String s) => switch (s) {
        AppConstants.statusPending => const Color(0xFFD97706),
        AppConstants.statusInProgress => Colors.redAccent,
        AppConstants.statusReady => const Color(0xFF2196F3),
        AppConstants.statusDelivered => const Color(0xFF00C48C),
        _ => Colors.grey,
      };

  @override
  Widget build(BuildContext context) {
    final d = doc.data() as Map<String, dynamic>;
    final colorScheme = Theme.of(context).colorScheme;

    final String orderIdShort =
        '#${doc.id.substring(0, doc.id.length.clamp(0, 8)).toUpperCase()}';
    final double total =
        double.tryParse(d['totalAmount']?.toString() ?? '0') ?? 0;
    final ts = d['orderTime'] as Timestamp?;
    final String timeLabel =
        ts != null ? DateFormat('HH:mm').format(ts.toDate()) : '--';
    final List items = d['items'] ?? [];
    final String itemsLabel = items.isEmpty
        ? '--'
        : items
            .map((e) => '${e['quantity'] ?? 1}× ${e['name'] ?? 'Item'}')
            .join(', ');
    final String orderType = d['orderType']?.toString() ?? 'delivery';
    final String paymentMethod = d['paymentMethod']?.toString() ?? 'cash';
    final bool isCash = paymentMethod == 'cash';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: colorScheme.surfaceBright, width: 1),
      ),
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 8, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: ID + time + menu
            Row(
              children: [
                Text(
                  orderIdShort,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                // Order type chip
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: (orderType == 'pickup'
                            ? Colors.purple
                            : Colors.blue.shade600)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    orderType == 'pickup' ? 'PICKUP' : 'DELIVERY',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: orderType == 'pickup'
                          ? Colors.purple
                          : Colors.blue.shade600,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  timeLabel,
                  style: TextStyle(fontSize: 11, color: brandColors.muted),
                ),
                if (!readOnly) ...[
                  const SizedBox(width: 4),
                  _StatusMenu(
                    orderID: doc.id,
                    statuses: _otherStatuses(),
                    colorFn: _statusColor,
                    onStatusChange: onStatusChange,
                  ),
                ],
              ],
            ),

            const SizedBox(height: 8),

            // Items
            Text(
              itemsLabel,
              style: TextStyle(fontSize: 12, color: brandColors.muted),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 10),

            // Bottom row: payment + total
            Row(
              children: [
                Icon(
                  isCash
                      ? Icons.payments_outlined
                      : Icons.credit_card_rounded,
                  size: 14,
                  color: isCash
                      ? const Color(0xFFD97706)
                      : const Color(0xFF2196F3),
                ),
                const SizedBox(width: 4),
                Text(
                  isCash ? 'Cash' : 'Card',
                  style: TextStyle(
                    fontSize: 11,
                    color: isCash
                        ? const Color(0xFFD97706)
                        : const Color(0xFF2196F3),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '${total.toStringAsFixed(2)} zł',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Status menu (three-dot dropdown) ─────────────────────────────────────────

class _StatusMenu extends StatelessWidget {
  final String orderID;
  final List<String> statuses;
  final Color Function(String) colorFn;
  final Future<void> Function(String, String)? onStatusChange;

  const _StatusMenu({
    required this.orderID,
    required this.statuses,
    required this.colorFn,
    this.onStatusChange,
  });

  IconData _statusIcon(String s) => switch (s) {
        AppConstants.statusPending => Icons.hourglass_empty_rounded,
        AppConstants.statusInProgress => Icons.restaurant_rounded,
        AppConstants.statusReady => Icons.delivery_dining_rounded,
        AppConstants.statusDelivered => Icons.check_circle_rounded,
        _ => Icons.circle_outlined,
      };

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert_rounded,
          size: 18, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)),
      padding: EdgeInsets.zero,
      tooltip: 'Move to status',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (newStatus) {
        onStatusChange?.call(orderID, newStatus);
      },
      itemBuilder: (_) => statuses.map((s) {
        final color = colorFn(s);
        return PopupMenuItem<String>(
          value: s,
          child: Row(
            children: [
              Icon(_statusIcon(s), color: color, size: 18),
              const SizedBox(width: 10),
              Text(
                'Move to $s',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: color,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}