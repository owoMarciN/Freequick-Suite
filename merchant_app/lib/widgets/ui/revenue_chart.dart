import 'package:flutter/material.dart';
import 'package:shared_assets/extensions/extensions.dart';

class RevenueChart extends StatelessWidget {
  final Map<String, double> data;
  final BrandColors brandColors;
  final ColorScheme colorScheme;

  const RevenueChart({
    super.key,
    required this.data,
    required this.brandColors,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final entries = data.entries.toList();

    final maxValue = entries.isEmpty
        ? 1.0
        : entries.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    final effectiveMax = maxValue == 0 ? 1.0 : maxValue;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // subtle top scale hint
          Text(
            '${effectiveMax.toStringAsFixed(0)} PLN',
            style: TextStyle(
              fontSize: 10,
              color: brandColors.muted,
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: entries.map((entry) {
                final value = entry.value;
                final ratio = value / effectiveMax;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Tooltip(
                      message: '${entry.key}: ${value.toStringAsFixed(2)} PLN',
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOutCubic,
                            height: (ratio * 130).clamp(4.0, 130.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  brandColors.primary!,
                                  brandColors.muted!,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: brandColors.primary!
                                      .withValues(alpha: 0.25),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 10),

          // X axis labels (adaptive density)
          Row(
            children: entries.asMap().entries.map((entry) {
              final index = entry.key;
              final label = entry.value.key;

              final show = entries.length <= 10 ||
                  index % (entries.length ~/ 6 + 1) == 0;

              return Expanded(
                child: Text(
                  show ? label : '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    color: brandColors.muted,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}