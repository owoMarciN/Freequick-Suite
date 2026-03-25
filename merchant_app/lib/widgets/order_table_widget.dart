import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merchant_app/extensions/extensions_import.dart';
import 'package:merchant_app/methods/assistant_methods.dart';
import 'package:merchant_app/widgets/progress_bar.dart';

class OrderTableWidget extends StatelessWidget {
  /// UID restauracji do filtrowania zamówień.
  final String? restaurantID;

  /// Lista statusów do wyświetlenia, np. ['Pending', 'In Progress', 'Ready', 'Out for Delivery'].
  final List<String> statuses;

  /// Maksymalna liczba wierszy (null = brak limitu).
  final int? limit;

  /// Jeśli true, kolumna statusu jest statyczna (tylko do odczytu).
  final bool readOnly;

  /// Wywoływane przy zmianie statusu przez użytkownika.
  final Future<void> Function(String orderID, String newStatus)? onStatusChange;

  const OrderTableWidget({
    super.key,
    required this.restaurantID,
    required this.statuses,
    this.limit,
    this.readOnly = false,
    this.onStatusChange,
  }) : assert(readOnly || onStatusChange != null,
            'onStatusChange is required when readOnly is false');

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>()!;
    final colorScheme = Theme.of(context).colorScheme;

    // Zapytanie do Firestore z filtrowaniem po przekazanej liście statusów
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection('orders')
        .where('restaurantID', isEqualTo: restaurantID)
        .where('status', whereIn: statuses)
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
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _EmptyState(brandColors: brandColors);
        }

        final docs = snapshot.data!.docs;

        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outline),
          ),
          child: Column(
            children: [
              // ── NAGŁÓWEK TABELI ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: _TableHeader('ID')),
                    Expanded(flex: 3, child: _TableHeader('CUSTOMER')),
                    Expanded(flex: 2, child: _TableHeader('TIME')),
                    Expanded(flex: 3, child: _TableHeader('STATUS')),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: _TableHeader('TOTAL'),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: colorScheme.outline),

              // ── WIERSZE ZAMÓWIEŃ ─────────────────────────────────────────
              ...docs.map((doc) {
                final d = doc.data() as Map<String, dynamic>;
                final String currentStatus = d['status']?.toString() ?? 'Pending';
                final String customer = d['userID']?.toString() ?? '—';
                final int items = (d['itemIDs'] as List?)?.length ?? 0;
                final double total =
                    double.tryParse(d['totalAmount']?.toString() ?? '0') ?? 0;
                final ts = d['orderTime'] as Timestamp?;
                final String timeLabel =
                    ts != null ? timestampToString(context, ts.toDate()) : '—';
                final String shortId =
                    '#${doc.id.substring(0, doc.id.length.clamp(0, 8))}';

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        children: [
                          // ID i Czas
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(shortId,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: brandColors.muted,
                                        fontFamily: 'monospace')),
                                const SizedBox(height: 2),
                                Text(timeLabel,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: brandColors.muted)),
                              ],
                            ),
                          ),

                          // Klient
                          Expanded(
                            flex: 3,
                            child: Text(customer,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis),
                          ),

                          // Liczba produktów
                          Expanded(
                            flex: 2,
                            child: Text(
                              items == 1
                                  ? context.l10n.overview_items_count(items)
                                  : context.l10n.overview_items_count_plural(items),
                              style: TextStyle(
                                  fontSize: 13, color: brandColors.muted),
                            ),
                          ),

                          // Wybór Statusu (Picker lub Chip)
                          Expanded(
                            flex: 3,
                            child: readOnly
                                ? _StatusChip(
                                    status: currentStatus, 
                                    brandColors: brandColors,
                                    showArrow: false,
                                  )
                                : _StatusPicker(
                                    currentStatus: currentStatus,
                                    availableStatuses: statuses,
                                    brandColors: brandColors,
                                    onChanged: (newStatus) =>
                                        onStatusChange!(doc.id, newStatus),
                                  ),
                          ),

                          // Suma
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${total.toStringAsFixed(2)} PLN',
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: colorScheme.outline),
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

// ── STATUS PICKER ────────────────────────────────────────────────────────────

class _StatusPicker extends StatelessWidget {
  final String currentStatus;
  final List<String> availableStatuses;
  final BrandColors brandColors;
  final Function(String) onChanged;

  const _StatusPicker({
    required this.currentStatus,
    required this.availableStatuses,
    required this.brandColors,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      initialValue: currentStatus,
      onSelected: onChanged,
      tooltip: 'Change status',
      offset: const Offset(0, 36),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (_) => availableStatuses
          .where((s) => s != currentStatus)
          .map((s) => PopupMenuItem<String>(
                value: s,
                child: Row(
                  children: [
                    _statusDot(s),
                    const SizedBox(width: 10),
                    Text(s, style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ))
          .toList(),
      child: _StatusChip(
        status: currentStatus, 
        brandColors: brandColors, 
        showArrow: true,
      ),
    );
  }

  Widget _statusDot(String status) {
    final color = switch (status) {
      'Pending' => const Color(0xFFD97706),
      'In Progress' => const Color(0xFF2563EB),
      'Ready' => const Color(0xFF16A34A),
      'Out for Delivery' => const Color(0xFF8B5CF6), // Fioletowy
      'Delivered' => const Color(0xFF6B7280),
      _ => const Color(0xFF6B7280),
    };
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

// ── STATUS CHIP ──────────────────────────────────────────────────────────────

class _StatusChip extends StatelessWidget {
  final String status;
  final BrandColors brandColors;
  final bool showArrow;

  const _StatusChip({
    required this.status, 
    required this.brandColors, 
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    // Definicja kolorów tła i tekstu dla każdego statusu
    final (Color bg, Color fg) = switch (status) {
      'Pending' => (const Color(0xFFFEF3C7), const Color(0xFFD97706)),
      'In Progress' => (const Color(0xFFDBEAFE), const Color(0xFF2563EB)),
      'Ready' => (const Color(0xFFDCFCE7), const Color(0xFF16A34A)),
      'Out for Delivery' => (const Color(0xFFEDE9FE), const Color(0xFF8B5CF6)), // Fioletowy styl
      'Delivered' => (const Color(0xFFF3F4F6), const Color(0xFF6B7280)),
      _ => (const Color(0xFFF3F4F6), const Color(0xFF6B7280)),
    };

    return UnconstrainedBox(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: bg, 
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              status,
              style: TextStyle(
                fontSize: 11, 
                fontWeight: FontWeight.w700, 
                color: fg,
              ),
            ),
            if (showArrow) ...[
              const SizedBox(width: 4),
              Icon(Icons.arrow_drop_down_rounded, size: 16, color: fg),
            ],
          ],
        ),
      ),
    );
  }
}

// ── POMOCNICZE WIDGETY ───────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final BrandColors brandColors;
  const _EmptyState({required this.brandColors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Text(
          'No orders found matching these criteria.',
          style: TextStyle(fontSize: 13, color: brandColors.muted),
        ),
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