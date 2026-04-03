import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rider_app/providers/rider_provider.dart';
import 'package:rider_app/utils/app_theme.dart';

/// A reusable card to display Today's Earnings and total deliveries.
/// Used in both Home and Profile sections.
class EarningsCard extends StatelessWidget {
  final RiderProvider provider;
  const EarningsCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    // Format for Polish Złoty
    final currencyFormat = NumberFormat.simpleCurrency(locale: 'PL', decimalDigits: 2);
    final earnings = provider.rider?.totalEarnings ?? 0.0;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primary.withValues(alpha: 0.15),
            AppTheme.primary.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today's Earnings",
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.account_balance_wallet_rounded, 
                color: AppTheme.primary.withValues(alpha: 0.75), 
                size: 32
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                currencyFormat.format(earnings),
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${provider.rider?.totalDeliveries ?? 0}',
                    style: const TextStyle(
                      color: AppTheme.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Text(
                    'Deliveries',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A small square/rectangular card for individual metrics like Rating or Vehicle.
class StatCard extends StatelessWidget {
  final String label;
  final Widget value;
  final Color color;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppTheme.textSecondary.withValues(alpha: 0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultTextStyle(
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              child: IconTheme(
                data: IconThemeData(color: color, size: 18),
                child: value,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper function to get consistent Vehicle Icons and Labels
Widget buildVehicleWidget(String type) {
  IconData iconData;
  String label;

  switch (type.toUpperCase()) {
    case 'BIKE':
      iconData = Icons.pedal_bike_rounded;
      label = 'Bike';
      break;
    case 'CAR':
      iconData = Icons.directions_car_rounded;
      label = 'Car';
      break;
    case 'SCOOTER':
    default:
      iconData = Icons.moped_rounded;
      label = 'Scooter';
      break;
  }

  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(iconData, size: 18),
      const SizedBox(width: 6),
      Text(label),
    ],
  );
}