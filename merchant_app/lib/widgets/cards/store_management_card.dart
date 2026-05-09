// ── Store Management Card ─────────────────────────────────────────────────────
// Drop this into settings_screen.dart after _BusinessInfoCard in the Column.
//
// Adds to the SettingsScreen Column (after _BusinessInfoCard, before the
// profile section header):
//
//   const SizedBox(height: 16),
//   _StoreManagementCard(
//     restaurantID: currentRestaurantUID,
//     data: restaurantData,
//     brandColors: brandColors,
//     colorScheme: colorScheme,
//   ),
//
// Writes to restaurants/{restaurantID}:
//   isOpen          bool    — temporary close toggle
//   acceptsDelivery bool    — delivery enabled toggle
//   acceptsPickup   bool    — pickup enabled toggle
//   minOrderAmount  double  — minimum order value in PLN
//   deliveryRadius  double  — delivery radius in km
//   openingHours    Map     — { mon: {open: "09:00", close: "22:00"}, ... }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_assets/extensions/extensions.dart';
import 'package:shared_assets/widgets/ui/unified_snackbar.dart';

const _kDays = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
const _kDayLabels = {
  'mon': 'Monday',
  'tue': 'Tuesday',
  'wed': 'Wednesday',
  'thu': 'Thursday',
  'fri': 'Friday',
  'sat': 'Saturday',
  'sun': 'Sunday',
};

// ── Main card ───────────────────────────────────────────────────────────────
class StoreManagementCard extends StatefulWidget {
  final String? restaurantID;
  final Map<String, dynamic> data;
  final BrandColors brandColors;
  final ColorScheme colorScheme;

  const StoreManagementCard({
    super.key,
    required this.restaurantID,
    required this.data,
    required this.brandColors,
    required this.colorScheme,
  });

  @override
  State<StoreManagementCard> createState() => _StoreManagementCardState();
}

class _StoreManagementCardState extends State<StoreManagementCard> {
  // Controllers
  late final TextEditingController _minOrderController;
  late final TextEditingController _radiusController;

  // Toggles
  late bool _isOpen;
  late bool _acceptsDelivery;
  late bool _acceptsPickup;

  // Hours: { 'mon': {'open': '09:00', 'close': '22:00', 'closed': false}, ... }
  late Map<String, Map<String, dynamic>> _hours;

  // Dirty tracking
  late Map<String, dynamic> _initials;
  bool _edited = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _setInitials();
    _applyInitials();
    _minOrderController.addListener(_onEdit);
    _radiusController.addListener(_onEdit);
  }

  void _setInitials() {
    final rawHours = widget.data['openingHours'] as Map<String, dynamic>? ?? {};
    _initials = {
      'isOpen': widget.data['isOpen'] ?? true,
      'acceptsDelivery': widget.data['acceptsDelivery'] ?? true,
      'acceptsPickup': widget.data['acceptsPickup'] ?? false,
      'minOrderAmount':
          (widget.data['minOrderAmount'] as num?)?.toDouble() ?? 0.0,
      'deliveryRadius':
          (widget.data['deliveryRadius'] as num?)?.toDouble() ?? 5.0,
      'openingHours': Map<String, dynamic>.from(rawHours),
    };
  }

  void _applyInitials() {
    _isOpen = _initials['isOpen'] as bool;
    _acceptsDelivery = _initials['acceptsDelivery'] as bool;
    _acceptsPickup = _initials['acceptsPickup'] as bool;
    _minOrderController = TextEditingController(
      text: (_initials['minOrderAmount'] as double) == 0.0
          ? ''
          : (_initials['minOrderAmount'] as double).toStringAsFixed(2),
    );
    _radiusController = TextEditingController(
      text: (_initials['deliveryRadius'] as double).toStringAsFixed(1),
    );
    final rawHours = _initials['openingHours'] as Map<String, dynamic>;
    _hours = {
      for (final day in _kDays)
        day: {
          'open': (rawHours[day] as Map?)?['open'] ?? '09:00',
          'close': (rawHours[day] as Map?)?['close'] ?? '22:00',
          'closed': (rawHours[day] as Map?)?['closed'] ?? false,
        },
    };
  }

  @override
  void didUpdateWidget(StoreManagementCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data && !_edited) {
      _setInitials();
      _isOpen = _initials['isOpen'] as bool;
      _acceptsDelivery = _initials['acceptsDelivery'] as bool;
      _acceptsPickup = _initials['acceptsPickup'] as bool;
      _minOrderController.text = (_initials['minOrderAmount'] as double) == 0.0
          ? ''
          : (_initials['minOrderAmount'] as double).toStringAsFixed(2);
      _radiusController.text =
          (_initials['deliveryRadius'] as double).toStringAsFixed(1);
      final rawHours = _initials['openingHours'] as Map<String, dynamic>;
      for (final day in _kDays) {
        _hours[day] = {
          'open': (rawHours[day] as Map?)?['open'] ?? '09:00',
          'close': (rawHours[day] as Map?)?['close'] ?? '22:00',
          'closed': (rawHours[day] as Map?)?['closed'] ?? false,
        };
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _minOrderController.dispose();
    _radiusController.dispose();
    super.dispose();
  }

  void _onEdit() {
    final dirty = _isOpen != _initials['isOpen'] ||
        _acceptsDelivery != _initials['acceptsDelivery'] ||
        _acceptsPickup != _initials['acceptsPickup'] ||
        (_minOrderController.text.isNotEmpty &&
            double.tryParse(_minOrderController.text) !=
                _initials['minOrderAmount']) ||
        (double.tryParse(_radiusController.text) !=
            _initials['deliveryRadius']) ||
        _hoursChanged();

    if (dirty != _edited) setState(() => _edited = dirty);
  }

  bool _hoursChanged() {
    final original = _initials['openingHours'] as Map<String, dynamic>;
    for (final day in _kDays) {
      final orig = original[day] as Map?;
      final cur = _hours[day]!;
      if ((orig?['open'] ?? '09:00') != cur['open']) return true;
      if ((orig?['close'] ?? '22:00') != cur['close']) return true;
      if ((orig?['closed'] ?? false) != cur['closed']) return true;
    }
    return false;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final minOrder = double.tryParse(_minOrderController.text) ?? 0.0;
      final radius = double.tryParse(_radiusController.text) ?? 5.0;

      final hoursMap = {
        for (final day in _kDays)
          day: {
            'open': _hours[day]!['open'],
            'close': _hours[day]!['close'],
            'closed': _hours[day]!['closed'],
          }
      };

      await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(widget.restaurantID)
          .update({
        'isOpen': _isOpen,
        'acceptsDelivery': _acceptsDelivery,
        'acceptsPickup': _acceptsPickup,
        'minOrderAmount': minOrder,
        'deliveryRadius': radius,
        'openingHours': hoursMap,
      });

      if (mounted) {
        setState(() => _edited = false);
        _setInitials();
        unifiedSnackBar('Store settings saved.');
      }
    } catch (e) {
      if (mounted) unifiedSnackBar(e.toString(), error: true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _pickTime(String day, String field) async {
    final current = _hours[day]![field] as String;
    final parts = current.split(':');
    final initial = TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 9,
      minute: int.tryParse(parts[1]) ?? 0,
    );
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked == null) return;
    setState(() {
      _hours[day]![field] =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      _edited = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final brand = widget.brandColors;
    final cs = widget.colorScheme;

    return StoreCard(
      colorScheme: cs,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StoreCardTitle(
            title: 'Store Management',
            brandColors: brand,
          ),
          const SizedBox(height: 20),

          // ── Temporary close ─────────────────────────────────────────────
          SwitchRow(
            icon: _isOpen
                ? Icons.store_rounded
                : Icons.store_mall_directory_rounded,
            iconColor: _isOpen ? brand.primary! : Colors.redAccent,
            title: 'Store Open',
            subtitle: _isOpen
                ? 'Your store is visible and accepting orders'
                : 'Store is temporarily closed — customers cannot order',
            value: _isOpen,
            activeColor: brand.primarySoft!,
            onChanged: (v) => setState(() {
              _isOpen = v;
              _onEdit();
            }),
          ),

          Divider(height: 1, color: cs.outline.withValues(alpha: 0.5)),

          // ── Delivery toggle ─────────────────────────────────────────────
          SwitchRow(
            icon: Icons.delivery_dining_rounded,
            iconColor: _acceptsDelivery ? brand.primary! : brand.muted!,
            title: 'Delivery',
            subtitle: 'Accept delivery orders',
            value: _acceptsDelivery,
            activeColor: brand.primarySoft!,
            onChanged: (v) => setState(() {
              _acceptsDelivery = v;
              _onEdit();
            }),
          ),

          Divider(height: 1, color: cs.outline.withValues(alpha: 0.5)),

          // ── Pickup toggle ───────────────────────────────────────────────
          SwitchRow(
            icon: Icons.storefront_rounded,
            iconColor: _acceptsPickup ? brand.primary! : brand.muted!,
            title: 'Pickup',
            subtitle: 'Accept self-collection orders',
            value: _acceptsPickup,
            activeColor: brand.primarySoft!,
            onChanged: (v) => setState(() {
              _acceptsPickup = v;
              _onEdit();
            }),
          ),

          Divider(height: 1, color: cs.outline.withValues(alpha: 0.5)),

          // ── Minimum order + delivery radius ─────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: NumericField(
                    controller: _minOrderController,
                    label: 'Min. Order (zł)',
                    icon: Icons.shopping_bag_outlined,
                    hint: '0.00',
                    suffix: 'zł',
                    brandColors: brand,
                    colorScheme: cs,
                    decimal: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NumericField(
                    controller: _radiusController,
                    label: 'Delivery Radius',
                    icon: Icons.radar_rounded,
                    hint: '5.0',
                    suffix: 'km',
                    brandColors: brand,
                    colorScheme: cs,
                    decimal: true,
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: cs.outline.withValues(alpha: 0.5)),

          // ── Opening hours ───────────────────────────────────────────────
          const SizedBox(height: 4),
          Text('Opening Hours',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: brand.primary)),
          const SizedBox(height: 12),

          ..._kDays.map((day) {
            final isClosed = _hours[day]!['closed'] as bool;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  // Day label
                  SizedBox(
                    width: 90,
                    child: Text(
                      _kDayLabels[day]!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isClosed ? brand.muted : cs.onSurface,
                      ),
                    ),
                  ),

                  // Closed toggle
                  GestureDetector(
                    onTap: () => setState(() {
                      _hours[day]!['closed'] = !isClosed;
                      _edited = true;
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isClosed
                            ? Colors.redAccent.withValues(alpha: 0.1)
                            : brand.primary!.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isClosed
                              ? Colors.redAccent.withValues(alpha: 0.3)
                              : brand.primary!.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        isClosed ? 'Closed' : 'Open',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isClosed ? Colors.redAccent : brand.primary,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Time pickers (hidden when closed)
                  if (!isClosed) ...[
                    Expanded(
                      child: TimeChip(
                        time: _hours[day]!['open'] as String,
                        label: 'Opens',
                        brand: brand,
                        cs: cs,
                        onTap: () => _pickTime(day, 'open'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text('–',
                          style: TextStyle(color: brand.muted, fontSize: 12)),
                    ),
                    Expanded(
                      child: TimeChip(
                        time: _hours[day]!['close'] as String,
                        label: 'Closes',
                        brand: brand,
                        cs: cs,
                        onTap: () => _pickTime(day, 'close'),
                      ),
                    ),
                  ] else
                    Expanded(
                      child: Text(
                        'Not available today',
                        style: TextStyle(fontSize: 11, color: brand.muted),
                      ),
                    ),
                ],
              ),
            );
          }),

          if (_edited) ...[
            const SizedBox(height: 8),
            StoreSaveButton(saving: _saving, onPressed: _save),
          ],
        ],
      ),
    );
  }
}

// ── Supporting widgets ────────────────────────────────────────────────────────

class SwitchRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool value;
  final Color activeColor;
  final ValueChanged<bool> onChanged;

  const SwitchRow({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.activeColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600)),
                Text(subtitle,
                    style: TextStyle(
                        fontSize: 11,
                        color:
                            Theme.of(context).extension<BrandColors>()!.muted)),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: activeColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class NumericField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String hint;
  final String suffix;
  final BrandColors brandColors;
  final ColorScheme colorScheme;
  final bool decimal;

  const NumericField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.hint,
    required this.suffix,
    required this.brandColors,
    required this.colorScheme,
    this.decimal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: brandColors.muted)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
                RegExp(decimal ? r'[\d.]' : r'\d')),
          ],
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 16, color: brandColors.muted),
            suffixText: suffix,
            suffixStyle: TextStyle(color: brandColors.muted, fontSize: 12),
            hintText: hint,
            hintStyle: TextStyle(color: brandColors.muted, fontSize: 13),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: brandColors.primary ?? Colors.blue, width: 1.5),
            ),
            filled: true,
            fillColor: colorScheme.surface,
          ),
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }
}

class TimeChip extends StatelessWidget {
  final String time;
  final String label;
  final BrandColors brand;
  final ColorScheme cs;
  final VoidCallback onTap;

  const TimeChip({
    super.key,
    required this.time,
    required this.label,
    required this.brand,
    required this.cs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: brand.primary!.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: brand.primary!.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 9,
                    color: brand.muted,
                    fontWeight: FontWeight.w500)),
            Text(time,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: brand.primary)),
          ],
        ),
      ),
    );
  }
}

class StoreCard extends StatelessWidget {
  final Widget child;
  final ColorScheme colorScheme;
  final Color? borderColor;

  const StoreCard({
    super.key,
    required this.child,
    required this.colorScheme,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor ?? colorScheme.outline),
      ),
      child: child,
    );
  }
}

class StoreCardTitle extends StatelessWidget {
  final String title;
  final BrandColors brandColors;

  const StoreCardTitle({
    super.key,
    required this.title,
    required this.brandColors,
  });

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700));
  }
}

class StoreSaveButton extends StatelessWidget {
  final bool saving;
  final VoidCallback onPressed;

  const StoreSaveButton({
    super.key,
    required this.saving,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>()!;
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 38,
        child: ElevatedButton(
          onPressed: saving ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: brandColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          child: saving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white))
              : const Text('Save Changes',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
