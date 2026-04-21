import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_assets/extensions/extensions.dart';
import 'package:merchant_app/models/status.dart';
import 'package:shared_assets/widgets/ui/progress_bar.dart';

class OrderTableWidget extends StatefulWidget {
  final String? restaurantID;
  final int? limit;

  const OrderTableWidget({
    super.key,
    required this.restaurantID,
    this.limit,
  });

  @override
  State<OrderTableWidget> createState() => _OrderTableWidgetState();
}

class _OrderTableWidgetState extends State<OrderTableWidget> {
  static const double _colOrder = 110;
  static const double _colTime = 100;
  static const double _colCustomer = 200;
  static const double _colItems = 200;
  static const double _colStatus = 140;
  static const double _colTotal = 120;

  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void dispose() {
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>()!;
    final colorScheme = Theme.of(context).colorScheme;

    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection('orders')
        .where('restaurantID', isEqualTo: widget.restaurantID)
        .where('status', whereIn: workflowStatuses)
        .orderBy('orderTime', descending: true);

    if (widget.limit != null) query = query.limit(widget.limit!);

    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: circularProgress());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _EmptyState(brandColors: brandColors);
        }

        final docs = snapshot.data?.docs ?? [];

        final columnWidths = <int, TableColumnWidth>{
          0: const FixedColumnWidth(_colOrder),
          1: const FixedColumnWidth(_colTime),
          2: const FixedColumnWidth(_colCustomer),
          3: const FixedColumnWidth(_colItems),
          4: const FixedColumnWidth(_colStatus),
          5: const FixedColumnWidth(_colTotal),
        };

        // Vertical scroll wrapper with scrollbar
        return Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          controller: _verticalScrollController,
          child: SingleChildScrollView(
            controller: _verticalScrollController,
            scrollDirection: Axis.vertical,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.surfaceBright),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Scrollbar(
                  thumbVisibility: true,
                  trackVisibility: true,
                  controller: _horizontalScrollController,
                  child: SingleChildScrollView(
                    controller: _horizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      columnWidths: columnWidths,
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        /// HEADER
                        TableRow(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: colorScheme.surfaceBright),
                            ),
                          ),
                          children: const [
                            _HeaderCell('ORDER'),
                            _HeaderCell('TIME'),
                            _HeaderCell('CUSTOMER'),
                            _HeaderCell('ITEMS'),
                            _HeaderCell('STATUS'),
                            _HeaderCell('TOTAL'),
                          ],
                        ),

                        /// DATA ROWS
                        ...docs.map((doc) {
                          final d = doc.data() as Map<String, dynamic>;

                          final String orderId = '#${doc.id.substring(0, 8)}';

                          final ts = d['orderTime'] as Timestamp?;
                          final String time = ts != null
                              ? DateFormat('HH:mm').format(ts.toDate())
                              : '—';

                          final List items = d['items'] ?? [];
                          final String itemsLabel = items
                              .map((i) => '${i['quantity']}× ${i['name']}')
                              .join(', ');

                          final double total = (d['subtotal'] ?? 0).toDouble();

                          return TableRow(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: colorScheme.surfaceBright),
                              ),
                            ),
                            children: [
                              _DataCell(
                                orderId,
                                isMono: true,
                                isBold: true,
                              ),
                              _DataCell(time),
                              _DataCell(
                                d['userID']?.toString() ?? '—',
                              ),
                              _DataCell(
                                itemsLabel,
                                isMuted: true,
                              ),
                              _StatusCell(
                                status: d['status'] ?? 'Pending',
                                brandColors: brandColors,
                              ),
                              _DataCell(
                                '${total.toStringAsFixed(2)} PLN',
                                isBold: true,
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
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

/// HEADER CELL
class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: Color(0xFF94A3B8),
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}

/// DATA CELL
class _DataCell extends StatelessWidget {
  final String text;
  final bool isMuted;
  final bool isBold;
  final bool isMono;

  const _DataCell(
    this.text, {
    this.isMuted = false,
    this.isBold = false,
    this.isMono = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
            color: isMuted ? Colors.grey : null,
            fontFamily: isMono ? 'monospace' : null,
          ),
        ),
      ),
    );
  }
}

/// STATUS CELL
class _StatusCell extends StatelessWidget {
  final String status;
  final BrandColors brandColors;

  const _StatusCell({
    required this.status,
    required this.brandColors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: _StatusChip(
          status: status,
          brandColors: brandColors,
        ),
      ),
    );
  }
}

/// STATUS CHIP
class _StatusChip extends StatelessWidget {
  final String status;
  final BrandColors brandColors;

  const _StatusChip({
    required this.status,
    required this.brandColors,
  });

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg) = switch (status) {
      'Pending' => (const Color(0xFFFEF3C7), const Color(0xFFD97706)),
      'In Progress' => (const Color(0xFFDBEAFE), const Color(0xFF2563EB)),
      'Ready' => (const Color(0xFFDCFCE7), const Color(0xFF16A34A)),
      'Given Out to Delivery' => (
          const Color(0xFFF3E8FF),
          const Color(0xFF7E22CE)
        ),
      _ => (const Color(0xFFF3F4F6), const Color(0xFF6B7280)),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: fg,
        ),
      ),
    );
  }
}

/// EMPTY STATE
class _EmptyState extends StatelessWidget {
  final BrandColors brandColors;

  const _EmptyState({required this.brandColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Text(
          'No recent orders.',
          style: TextStyle(color: brandColors.muted),
        ),
      ),
    );
  }
}