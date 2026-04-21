import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_assets/extensions/extensions.dart';
import 'package:merchant_app/models/status.dart';
import 'package:shared_assets/widgets/ui/progress_bar.dart';

class OrderTableWidget extends StatelessWidget {
  final String? restaurantID;
  final int? limit;

  const OrderTableWidget({
    super.key,
    required this.restaurantID,
    this.limit,
  });

  // Fixed column widths for consistent header/row alignment
  static const double _colOrder = 110;
  static const double _colTime = 100;
  static const double _colCustomer = 200;
  static const double _colItems = 120;
  static const double _colStatus = 120;
  static const double _colTotal = 100;

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>()!;
    final colorScheme = Theme.of(context).colorScheme;

    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection('orders')
        .where('restaurantID', isEqualTo: restaurantID)
        .where('status', whereIn: workflowStatuses)
        .orderBy('orderTime', descending: true);

    if (limit != null) query = query.limit(limit!);

    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: circularProgress());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _EmptyState(brandColors: brandColors);
        }

        final docs = snapshot.data!.docs;

        return Container(
          // 1. ADDED PADDING HERE: Creates the frame around the entire table
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.surfaceBright),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ScrollableTable(
                docs: docs,
                brandColors: brandColors,
                colorScheme: colorScheme,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ScrollableTable extends StatefulWidget {
  final List<QueryDocumentSnapshot> docs;
  final BrandColors brandColors;
  final ColorScheme colorScheme;

  const _ScrollableTable({
    required this.docs,
    required this.brandColors,
    required this.colorScheme,
  });

  @override
  State<_ScrollableTable> createState() => _ScrollableTableState();
}

class _ScrollableTableState extends State<_ScrollableTable> {
  final ScrollController _headerScrollController = ScrollController();
  final ScrollController _bodyScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Keep header and body horizontally in sync
    _bodyScrollController.addListener(() {
      if (_headerScrollController.hasClients) {
        _headerScrollController.jumpTo(_bodyScrollController.offset);
      }
    });
  }

  @override
  void dispose() {
    _headerScrollController.dispose();
    _bodyScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- HEADER ---
        SingleChildScrollView(
          controller: _headerScrollController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            // Removed horizontal padding because the parent Container now handles the frame
            padding: const EdgeInsets.only(bottom: 14),
            child: const _TableRow(isHeader: true),
          ),
        ),
        Divider(height: 1, color: widget.colorScheme.surfaceBright),

        // --- BODY ---
        Scrollbar(
          controller: _bodyScrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: _bodyScrollController,
            scrollDirection: Axis.horizontal,
            child: Padding(
              // 2. ADDED BOTTOM PADDING: Gives the scrollbar space so it doesn't overlap the table data
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(widget.docs.length * 2 - 1, (i) {
                  if (i.isOdd) {
                    return Divider(
                        height: 1, color: widget.colorScheme.surfaceBright);
                  }
                  final index = i ~/ 2;
                  final doc = widget.docs[index];
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

                  return Padding(
                    // Removed horizontal padding here as well
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: _TableRow(
                      orderId: orderId,
                      time: time,
                      customer: d['userID']?.toString() ?? '—',
                      itemsLabel: itemsLabel,
                      status: d['status'] ?? 'Pending',
                      total: d['subtotal'] ?? 0,
                      brandColors: widget.brandColors,
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TableRow extends StatelessWidget {
  final bool isHeader;
  final String? orderId;
  final String? time;
  final String? customer;
  final String? itemsLabel;
  final String? status;
  final dynamic total;
  final BrandColors? brandColors;

  const _TableRow({
    this.isHeader = false,
    this.orderId,
    this.time,
    this.customer,
    this.itemsLabel,
    this.status,
    this.total,
    this.brandColors,
  });

  // 3. ADDED HELPER: Ensures every cell is strictly aligned to the left
  Widget _buildCell(double width, Widget child) {
    return SizedBox(
      width: width,
      child: Align(
        alignment: Alignment.centerLeft,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isHeader) {
      return Row(
        children: [
          _buildCell(OrderTableWidget._colOrder, const _TableHeader('ORDER')),
          _buildCell(OrderTableWidget._colTime, const _TableHeader('TIME')),
          _buildCell(
              OrderTableWidget._colCustomer, const _TableHeader('CUSTOMER')),
          _buildCell(OrderTableWidget._colItems, const _TableHeader('ITEMS')),
          _buildCell(OrderTableWidget._colStatus, const _TableHeader('STATUS')),
          _buildCell(OrderTableWidget._colTotal, const _TableHeader('TOTAL')),
        ],
      );
    }

    return Row(
      children: [
        _buildCell(
          OrderTableWidget._colOrder,
          Text(
            orderId ?? '—',
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace'),
          ),
        ),
        _buildCell(
          OrderTableWidget._colTime,
          Text(time ?? '—', style: const TextStyle(fontSize: 12)),
        ),
        _buildCell(
          OrderTableWidget._colCustomer,
          Text(
            customer ?? '—',
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _buildCell(
          OrderTableWidget._colItems,
          Text(
            itemsLabel ?? '—',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _buildCell(
          OrderTableWidget._colStatus,
          _StatusChip(
            status: status ?? 'Pending',
            brandColors: brandColors!,
          ),
        ),
        _buildCell(
          OrderTableWidget._colTotal,
          Text(
            '${total.toStringAsFixed(2)} PLN',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  final BrandColors brandColors;

  const _StatusChip({required this.status, required this.brandColors});

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
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: fg),
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  final String text;
  const _TableHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: Color(0xFF94A3B8),
          letterSpacing: 0.8),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final BrandColors brandColors;
  const _EmptyState({required this.brandColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Text('No recent orders.',
            style: TextStyle(color: brandColors.muted)),
      ),
    );
  }
}
