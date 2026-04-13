import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merchant_app/extensions/extensions_import.dart';
import 'package:merchant_app/widgets/ui/progress_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>()!;
    final colorScheme = Theme.of(context).colorScheme;

    if (visibleStatuses.isEmpty) {
      return _EmptyState(
        message: 'Select a status above to view orders.',
        brandColors: brandColors,
      );
    }

    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection('orders')
        .where('restaurantID', isEqualTo: restaurantID)
        .where('status', whereIn: visibleStatuses)
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
            child: Text('Error loading orders',
                style: TextStyle(color: brandColors.muted)),
          );
        }

        final docs = snapshot.data?.docs ?? [];
        final Map<String, List<QueryDocumentSnapshot>> groupedOrders = {
          for (var status in visibleStatuses) status: []
        };

        for (var doc in docs) {
          final data = doc.data() as Map<String, dynamic>;
          final status = data['status']?.toString() ?? 'Pending';
          if (groupedOrders.containsKey(status)) {
            groupedOrders[status]!.add(doc);
          }
        }

        // --- THE FRAME ---
        // This container defines the "area" where the board and scrollbar live.
        return Center(
          child: Container(
            height: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: colorScheme
                  .surfaceContainerLow, // Subtle background for the frame
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
              child: Scrollbar(
                controller: _bodyScrollController,
                thumbVisibility: true,
                trackVisibility: true,
                child: SingleChildScrollView(
                  controller: _bodyScrollController,
                  scrollDirection: Axis.horizontal,
                  // THE PADDING: This adds space at the bottom so the horizontal
                  // scrollbar doesn't cover your cards.
                  padding: const EdgeInsets.only(
                      bottom: 20, left: 16, right: 16, top: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: visibleStatuses.map((status) {
                      return SizedBox(
                        width: 320,
                        child: _BoardColumn(
                          status: status,
                          orders: groupedOrders[status]!,
                          brandColors: brandColors,
                          readOnly: readOnly,
                          onStatusChange: onStatusChange,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// --- BOARD COLUMN ---
class _BoardColumn extends StatelessWidget {
  final String status;
  final List<QueryDocumentSnapshot> orders;
  final BrandColors brandColors;
  final bool readOnly;
  final Future<void> Function(String, String)? onStatusChange;

  const _BoardColumn({
    required this.status,
    required this.orders,
    required this.brandColors,
    required this.readOnly,
    this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DragTarget<String>(
      onWillAcceptWithDetails: (details) => !readOnly,
      onAcceptWithDetails: (details) {
        if (onStatusChange != null) {
          onStatusChange!(details.data, status);
        }
      },
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: isHovered
                ? colorScheme.primaryContainer.withValues(alpha: 0.3)
                : colorScheme.surface.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isHovered ? colorScheme.primary : colorScheme.surfaceBright,
              width: isHovered ? 3 : 2,
            ),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        status.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    Badge(
                      label: Text(
                        orders.length.toString(),
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.blueAccent,
                      textColor: colorScheme.onSecondaryContainer,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 2,
                color: colorScheme.surfaceBright,
              ),

              // Orders List
              Expanded(
                child: orders.isEmpty
                    ? Center(
                        child: Text(
                          'Empty',
                          style:
                              TextStyle(color: brandColors.muted, fontSize: 12),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final doc = orders[index];
                          final card =
                              _OrderCard(doc: doc, brandColors: brandColors);

                          if (readOnly) return card;

                          return Draggable<String>(
                            data: doc.id,
                            feedback: Material(
                              color: Colors.transparent,
                              child: SizedBox(width: 280, child: card),
                            ),
                            childWhenDragging:
                                Opacity(opacity: 0.4, child: card),
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

// --- ORDER CARD ---
class _OrderCard extends StatelessWidget {
  final QueryDocumentSnapshot doc;
  final BrandColors brandColors;

  const _OrderCard({required this.doc, required this.brandColors});

  @override
  Widget build(BuildContext context) {
    final d = doc.data() as Map<String, dynamic>;
    final colorScheme = Theme.of(context).colorScheme;

    final String orderIdShort =
        '#${doc.id.substring(0, doc.id.length.clamp(0, 8))}';
    final String customer = d['userID']?.toString() ?? '—';
    final double total = double.tryParse(d['subtotal']?.toString() ?? '0') ?? 0;

    final ts = d['orderTime'] as Timestamp?;
    final String timeLabel =
        ts != null ? DateFormat('HH:mm').format(ts.toDate()) : '—';

    final List items = d['items'] ?? [];
    final String itemsLabel = items.isEmpty
        ? '—'
        : items
            .map(
                (item) => '${item['quantity'] ?? 1}x ${item['name'] ?? 'Item'}')
            .join(', ');

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: colorScheme.surfaceBright, width: 2),
      ),
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderIdShort,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  timeLabel,
                  style: TextStyle(fontSize: 11, color: brandColors.muted),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              customer,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              itemsLabel,
              style: TextStyle(fontSize: 12, color: brandColors.muted),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${total.toStringAsFixed(2)} PLN',
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String message;
  final BrandColors brandColors;
  const _EmptyState({required this.message, required this.brandColors});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message, style: TextStyle(color: brandColors.muted)),
    );
  }
}
