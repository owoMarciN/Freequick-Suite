import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rider_app/models/dispatch_model.dart';
import 'package:shared_assets/extensions/extensions.dart';

class JobRequestSheet extends StatefulWidget {
  final DispatchJob job;
  final Future<void> Function() onAccept;
  final Future<void> Function() onReject;
  final int timeoutSeconds;

  const JobRequestSheet({
    super.key,
    required this.job,
    required this.onAccept,
    required this.onReject,
    this.timeoutSeconds = 60,
  });

  @override
  State<JobRequestSheet> createState() => _JobRequestSheetState();
}

class _JobRequestSheetState extends State<JobRequestSheet>
    with SingleTickerProviderStateMixin {
  late int _secondsLeft;
  Timer? _timer;
  late AnimationController _pulse;
  bool _showItems = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.timeoutSeconds;

    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() => _secondsLeft--);
      if (_secondsLeft <= 0) {
        t.cancel();
        widget.onReject();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulse.dispose();
    super.dispose();
  }

  Future<void> _safeAccept() async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      _timer?.cancel();
      await widget.onAccept();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      debugPrint('ACCEPT ERROR: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10nRider.errorApplication(e.toString())),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _safeReject() async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      _timer?.cancel();
      await widget.onReject();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      debugPrint('REJECT ERROR: $e');
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final job = widget.job;
    final progress = _secondsLeft / widget.timeoutSeconds;
    final isLowTime = _secondsLeft <= 10;
    final brand = Theme.of(context).extension<BrandColors>()!;
    final scheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: brand.primary!.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: brand.primary!.withValues(alpha: 0.15),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  children: [
                    AnimatedBuilder(
                      animation: _pulse,
                      builder: (_, __) => Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: brand.primary!.withValues(
                            alpha: 0.1 + 0.12 * _pulse.value,
                          ),
                        ),
                        child: Icon(
                          Icons.delivery_dining_rounded,
                          color: brand.primary,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10nRider.jobNewJob,
                            style: TextStyle(
                              color: brand.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            isLowTime
                                ? context.l10nRider.jobAutorejecting(
                                    _secondsLeft,
                                  )
                                : context.l10nRider.jobExpiresIn(_secondsLeft),
                            style: TextStyle(
                              color: isLowTime
                                  ? brand.danger
                                  : brand.primaryDark,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Badge with payment
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: brand.primary!.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: brand.primary!.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Text(
                        'zł ${(job.deliveryFee).toStringAsFixed(2)}',
                        style: TextStyle(
                          color: brand.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Timer
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5,
                    backgroundColor: Theme.of(context).dividerColor,
                    valueColor: AlwaysStoppedAnimation(
                      isLowTime ? brand.danger : brand.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: brand.cardSurface,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      _RouteRow(
                        icon: Icons.store_rounded,
                        iconColor: brand.primarySoft!,
                        label: context.l10nRider.jobPickupFrom,
                        value: job.restaurantName,
                        sub: job.restaurantAddress,
                      ),
                      const SizedBox(height: 8),
                      _RouteRow(
                        icon: Icons.location_on_rounded,
                        iconColor: brand.danger!,
                        label: context.l10nRider.jobShipTo,
                        value:
                            job.customerName ??
                            context.l10nRider.jobDefaultCustomer,
                        sub: job.customerAddress,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Statystyki zlecenia
                Row(
                  children: [
                    _StatChip(
                      icon: Icons.payments_outlined,
                      label: _isCash(job.paymentMethod)
                          ? context.l10nRider.jobPaymentCash(
                              job.finalTotal.toStringAsFixed(2),
                            )
                          : context.l10nRider.jobPaymentCard,
                      color: _isCash(job.paymentMethod)
                          ? brand.warning!
                          : brand.primary!,
                    ),
                    const SizedBox(width: 8),
                    _StatChip(
                      icon: Icons.receipt_long_outlined,
                      label: context.l10nRider.jobItemsCount(job.items.length),
                      color: brand.primarySoft!,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                if (job.collectPayment || _isCash(job.paymentMethod)) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: brand.warning!.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: brand.warning!.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          color: brand.warning,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            context.l10nRider.jobCollectPaymentWarning(
                              job.finalTotal.toStringAsFixed(2),
                            ),
                            style: TextStyle(
                              color: brand.warning,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                // Lista produktów (rozwijana)
                _buildExpandableItems(job),

                const SizedBox(height: 16),

                // Przyciski Akcji
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _safeReject,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: brand.danger,
                          side: BorderSide(color: brand.danger!),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(context.l10nRider.jobActionReject),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: _safeAccept,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(context.l10nRider.jobActionAccept),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableItems(DispatchJob job) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _showItems = !_showItems),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: scheme.surfaceBright,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood_outlined,
                  color: brand.primaryDark,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  _showItems
                      ? context.l10nRider.jobHideProducts
                      : context.l10nRider.jobShowProducts,
                  style: TextStyle(color: brand.primaryDark, fontSize: 13),
                ),
                const Spacer(),
                Icon(
                  _showItems
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: brand.primaryDark,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        if (_showItems)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: brand.cardSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: job.items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Text(
                            '${item.quantity}x',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(item.name)),
                          Text('zł ${(item.price).toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }

  bool _isCash(String method) => method.toLowerCase() == 'cash';
}

class _RouteRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final String? sub;

  const _RouteRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.sub,
  });

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: brand.primaryDark, fontSize: 10),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              if (sub != null)
                Text(
                  sub!,
                  style: TextStyle(color: brand.primaryDark, fontSize: 11),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 14),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: TextStyle(color: color, fontSize: 11),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
