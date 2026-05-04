// lib/screens/orders/order_details_screen.dart
//
// Customer app — order details with status timeline, summary,
// live tracking button, and post-delivery rating prompt.
//
// Status flow (AppConstants, synced with Cloud Functions):
//   statusPending → statusInProgress → statusReady → statusDelivered

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_app/models/address.dart';
import 'package:shared_assets/widgets/ui/progress_bar.dart';
import 'package:user_app/widgets/designs/shipment_address_design.dart';
import 'package:user_app/widgets/ui/unified_app_bar.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/widgets/ratings/rate_order_sheet.dart';
import 'package:shared_assets/methods/shared_methods.dart';
import 'package:shared_assets/extensions/extensions.dart';
import 'package:user_app/screens/orders/delivery_tracking_screen.dart';

// Adjust this import to wherever AppConstants lives in the customer app.
// If it is only in rider_app, copy the relevant constants to shared_assets.
import 'package:shared_assets/utils/app_constants.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String? orderID;
  const OrderDetailsScreen({super.key, this.orderID});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool _ratingPrompted = false;

  void _maybeShowRatingPrompt(Map<String, dynamic> data) {
    if (_ratingPrompted) return;
    final status = data[AppConstants.fieldStatus]?.toString() ?? '';
    if (status != AppConstants.statusDelivered) return;
    if (data['rating'] != null) return;
    _ratingPrompted = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showRateOrderSheet(
        context,
        orderID: widget.orderID ?? '',
        restaurantID: data['restaurantID']?.toString() ?? '',
        restaurantName: data['restaurantName']?.toString() ?? 'Restaurant',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10nCommon;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6FB),
      appBar: UnifiedAppBar(
        title: t.orderDetails,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.white, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection(AppConstants.colUsers)
            .doc(currentUID)
            .collection(AppConstants.colOrders)
            .doc(widget.orderID)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: circularProgress());
          }

          final data = snapshot.data!.data()! as Map<String, dynamic>;
          final status = data[AppConstants.fieldStatus]?.toString() ??
              AppConstants.statusPending;

          _maybeShowRatingPrompt(data);

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _OrderProgressCard(
                  status: status,
                  data: data,
                  orderID: widget.orderID ?? '',
                ),
                const SizedBox(height: 20),
                _SectionLabel(t.orderSummary),
                const SizedBox(height: 10),
                _SummaryCard(data: data, orderID: widget.orderID),
                const SizedBox(height: 20),

                if (data['rating'] != null)
                  _RatedBadge(
                    foodRating: (data['rating'] as num).toInt(),
                    driverRating:
                        (data['driverRating'] as num?)?.toInt() ?? 0,
                  ),

                if (data['rating'] != null) const SizedBox(height: 20),

                if (data['orderType'] != 'pickup') ...[
                  _SectionLabel(t.deliveryAddress),
                  const SizedBox(height: 10),
                  _AddressSection(data: data),
                ] else ...[
                  _SectionLabel(t.pickupLocation),
                  const SizedBox(height: 10),
                  const _PickupCard(),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

// ── Order progress card ───────────────────────────────────────────────────────

class _OrderProgressCard extends StatelessWidget {
  final String status;
  final Map<String, dynamic> data;
  final String orderID;

  const _OrderProgressCard({
    required this.status,
    required this.data,
    required this.orderID,
  });

  // Pipeline in order — matches AppConstants and Cloud Functions
  static const _pipeline = [
    AppConstants.statusPending,
    AppConstants.statusInProgress,
    AppConstants.statusReady,
    AppConstants.statusDelivered,
  ];

  List<_Step> _steps(BuildContext context) {
    final t = context.l10nCommon;
    return [
      _Step(
        label: t.labelProcessing,
        sublabel: t.sublabelProcessing,
        icon: Icons.receipt_long_rounded,
        value: AppConstants.statusPending,
      ),
      _Step(
        label: t.labelAccepted,
        sublabel: t.sublabelAccepted,
        icon: Icons.restaurant_rounded,
        value: AppConstants.statusInProgress,
      ),
      _Step(
        label: t.labelOnWay,
        sublabel: t.sublabelOnWay,
        icon: Icons.delivery_dining_rounded,
        value: AppConstants.statusReady,
      ),
      _Step(
        label: t.statusDelivered,
        sublabel: t.labelEnjoy,
        icon: Icons.check_circle_rounded,
        value: AppConstants.statusDelivered,
      ),
    ];
  }

  bool get _isActiveDelivery =>
      (status == AppConstants.statusInProgress ||
          status == AppConstants.statusReady) &&
      data['orderType'] != 'pickup';

  @override
  Widget build(BuildContext context) {
    final steps = _steps(context);
    final currentIndex = _pipeline.indexOf(status).clamp(0, _pipeline.length - 1);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.local_shipping_rounded,
                    size: 16, color: Colors.redAccent),
              ),
              const SizedBox(width: 10),
              Text(
                context.l10nCommon.orderStatus,
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w800),
              ),
              const Spacer(),
              _StatusBadge(status: status),
            ],
          ),
          const SizedBox(height: 24),
          ...List.generate(
            steps.length,
            (i) => _TimelineRow(
              step: steps[i],
              isDone: i <= currentIndex,
              isActive: i == currentIndex,
              isLast: i == steps.length - 1,
            ),
          ),

          // Track delivery button — only for active delivery orders
          if (_isActiveDelivery) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DeliveryTrackingScreen(
                      orderID: orderID,
                      restaurantName:
                          data['restaurantName']?.toString() ?? '',
                    ),
                  ),
                ),
                icon: const Icon(Icons.map_rounded, size: 18),
                label: const Text('Track delivery'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4757),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Step {
  final String label, sublabel, value;
  final IconData icon;
  const _Step({
    required this.label,
    required this.sublabel,
    required this.icon,
    required this.value,
  });
}

// ── Timeline row ──────────────────────────────────────────────────────────────

class _TimelineRow extends StatelessWidget {
  final _Step step;
  final bool isDone, isActive, isLast;

  const _TimelineRow({
    required this.step,
    required this.isDone,
    required this.isActive,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    const activeColor = Colors.redAccent;
    const doneColor = Color(0xFF00C48C);
    final pendingColor = Colors.grey.shade200;

    final dotColor =
        isDone ? (isActive ? activeColor : doneColor) : pendingColor;
    final lineColor = isDone && !isActive ? doneColor : pendingColor;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 36,
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: dotColor.withValues(alpha: isDone ? 1 : 0.3),
                  shape: BoxShape.circle,
                  border: isActive
                      ? Border.all(color: activeColor, width: 2)
                      : null,
                ),
                child: Icon(step.icon,
                    size: 18,
                    color:
                        isDone ? Colors.white : Colors.grey.shade400),
              ),
              if (!isLast)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 2,
                  height: 36,
                  color: lineColor,
                ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 6, bottom: isLast ? 0 : 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isActive
                        ? FontWeight.w800
                        : FontWeight.w600,
                    color: isActive
                        ? Colors.black87
                        : isDone
                            ? const Color(0xFF00C48C)
                            : Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  step.sublabel,
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive
                        ? Colors.grey.shade600
                        : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isDone && !isActive)
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Icon(Icons.check_rounded,
                size: 16, color: Color(0xFF00C48C)),
          ),
      ],
    );
  }
}

// ── Status badge ──────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final common = context.l10nCommon;
    final (Color bg, Color fg, String label) = switch (status) {
      AppConstants.statusPending => (
          const Color(0xFFFEF3C7),
          const Color(0xFFD97706),
          common.statusPending,
        ),
      AppConstants.statusInProgress => (
          Colors.redAccent.withValues(alpha: 0.1),
          Colors.redAccent,
          common.statusInProgress,
        ),
      AppConstants.statusReady => (
          Colors.blue.shade50,
          Colors.blue.shade700,
          common.statusReady,
        ),
      AppConstants.statusDelivered => (
          const Color(0xFF00C48C).withValues(alpha: 0.1),
          const Color(0xFF00C48C),
          common.statusDelivered,
        ),
      _ => (Colors.grey.shade100, Colors.grey.shade600, status),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w700, color: fg)),
    );
  }
}

// ── Summary card ──────────────────────────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final String? orderID;
  const _SummaryCard({required this.data, required this.orderID});

  @override
  Widget build(BuildContext context) {
    final common = context.l10nCommon;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(common.total,
                  style: TextStyle(
                      fontSize: 13, color: Colors.grey.shade500)),
              Text(
                common.currency_pl(
                    data['totalAmount']?.toString() ?? '0.00'),
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.redAccent),
              ),
            ],
          ),
          if ((data['deliveryFee'] ?? '0.00') != '0.00') ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(common.deliveryFee,
                    style: TextStyle(
                        fontSize: 12, color: Colors.grey.shade500)),
                Text(
                    common.currency_pl(
                        data['deliveryFee'].toString()),
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: Color(0xFFF0F0F0)),
          ),
          _InfoRow(
            icon: Icons.receipt_long_rounded,
            label: common.orderId,
            value: '#${orderID?.substring(0, 12) ?? ''}…',
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: data['orderType'] == 'pickup'
                ? Icons.storefront_rounded
                : Icons.delivery_dining_rounded,
            label: common.orderType,
            value: data['orderType'] == 'pickup'
                ? context.l10nCommon.pickup
                : context.l10nCommon.foodDelivery,
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.schedule_rounded,
            label: common.orderedAt,
            value: dateTimeToString(context, data['orderTime'].toDate()),
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.payments_rounded,
            label: common.payment,
            value: formatPayment(context, data['paymentDetails']),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _InfoRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade400),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 11, color: Colors.grey.shade500)),
              const SizedBox(height: 1),
              Text(value,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Address section ───────────────────────────────────────────────────────────

class _AddressSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const _AddressSection({required this.data});

  @override
  Widget build(BuildContext context) {
    final common = context.l10nCommon;

    if (data['address'] is Map) {
      final addr = Address.fromJson(
          Map<String, dynamic>.from(data['address'] as Map));
      return ShipmentAddressDesign(model: addr);
    }

    final addressID = data['addressID'] as String?;
    if (addressID == null ||
        addressID.isEmpty ||
        addressID == 'pickup') {
      return _InfoTile(
          icon: Icons.location_off_rounded,
          text: common.errorAddressNotAvailable);
    }

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection(AppConstants.colUsers)
          .doc(currentUID)
          .collection('addresses')
          .doc(addressID)
          .get(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16)),
            child: Center(child: circularProgress()),
          );
        }
        if (!snap.data!.exists) {
          return _InfoTile(
              icon: Icons.location_off_rounded,
              text: common.errorAddressNotFound);
        }
        return ShipmentAddressDesign(
            model: Address.fromJson(
                snap.data!.data()! as Map<String, dynamic>));
      },
    );
  }
}

// ── Pickup card ───────────────────────────────────────────────────────────────

class _PickupCard extends StatelessWidget {
  const _PickupCard();

  @override
  Widget build(BuildContext context) {
    final t = context.l10nCommon;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.redAccent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.storefront_rounded,
                color: Colors.redAccent, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.pickupFromStore,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(t.pickupCounterHint,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFFAAAAAA))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Info tile ─────────────────────────────────────────────────────────────────

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade400, size: 18),
          const SizedBox(width: 12),
          Text(text,
              style:
                  TextStyle(fontSize: 13, color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}

// ── Section label ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Colors.black87));
  }
}

// ── Rated badge ───────────────────────────────────────────────────────────────

class _RatedBadge extends StatelessWidget {
  final int foodRating;
  final int driverRating;
  const _RatedBadge(
      {required this.foodRating, required this.driverRating});

  @override
  Widget build(BuildContext context) {
    final t = context.l10nCommon;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF00C48C).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: const Color(0xFF00C48C).withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded,
              color: Color(0xFF00C48C), size: 20),
          const SizedBox(width: 10),
          Text(t.youRatedOrder,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF00C48C))),
          const Spacer(),
          _MiniStars(label: t.ratingFood, rating: foodRating),
          const SizedBox(width: 12),
          _MiniStars(label: t.ratingDriver, rating: driverRating),
        ],
      ),
    );
  }
}

class _MiniStars extends StatelessWidget {
  final String label;
  final int rating;
  const _MiniStars({required this.label, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 9,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 2),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (i) => Icon(
              i < rating
                  ? Icons.star_rounded
                  : Icons.star_outline_rounded,
              size: 12,
              color: i < rating
                  ? Colors.amber.shade600
                  : Colors.grey.shade300,
            ),
          ),
        ),
      ],
    );
  }
}