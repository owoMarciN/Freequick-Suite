import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/models/rider_model.dart';
import 'package:rider_app/providers/rider_provider.dart';
import 'package:rider_app/providers/rider_stats_provider.dart';
import 'package:shared_assets/extensions/extensions.dart';
import 'package:shared_assets/providers/theme_provider.dart';
import 'package:rider_app/widgets/stats/rider_stats_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: Consumer2<RiderProvider, RiderStatsProvider>(
        builder: (context, provider, stats, _) {
          final rider = provider.rider;
          if (rider == null || stats.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: brand.primary),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                _ProfileHeader(rider: rider),
                const SizedBox(height: 24),
                _StatsGrid(
                  rider: rider,
                  stats: stats,
                  isOnline: provider.isOnline,
                ),
                const SizedBox(height: 24),
                _EarningsBreakdown(stats: stats),
                const SizedBox(height: 24),
                _SettingsSection(),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}

// --- Profile Header ---
class _ProfileHeader extends StatelessWidget {
  final RiderModel rider;
  const _ProfileHeader({required this.rider});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;

    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [brand.primary!, brand.primaryDark!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: brand.primary!.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Text(
              rider.name.isNotEmpty ? rider.name[0].toUpperCase() : 'R',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          rider.name,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: brand.primary,
          ),
        ),
        Text(
          rider.phone,
          style: TextStyle(
            color: brand.primaryDark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// --- Reusable Stats Grid ---
class _StatsGrid extends StatelessWidget {
  final RiderModel rider;
  final RiderStatsProvider stats;
  final bool isOnline;
  const _StatsGrid({
    required this.rider,
    required this.stats,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;

    return Row(
      children: [
        StatCard(
          label: context.l10nRider.statDeliveries,
          color: brand.primary!,
          value: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.auto_awesome_rounded, size: 16),
              const SizedBox(width: 4),
              Text('${stats.totalDeliveries}'),
            ],
          ),
        ),
        const SizedBox(width: 12),
        StatCard(
          label: context.l10nRider.statRating,
          color: brand.warning!,
          value: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star_rounded, size: 16),
              const SizedBox(width: 4),
              Text(
                stats.totalRatings > 0
                    ? stats.avgDriverRating.toStringAsFixed(1)
                    : '—',
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        StatCard(
          label: context.l10nRider.statVehicle,
          color: brand.primarySoft!,
          value: buildVehicleWidget(rider.vehicleType),
        ),
      ],
    );
  }
}

// --- Earnings Breakdown ---
class _EarningsBreakdown extends StatelessWidget {
  final RiderStatsProvider stats;
  const _EarningsBreakdown({required this.stats});

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: brand.cardSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: brand.primaryDark!.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10nRider.performanceSummary,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: brand.primary,
            ),
          ),
          const SizedBox(height: 20),
          _EarningsRow(
            label: context.l10nRider.timeToday,
            earnings: stats.todayEarningsFormatted,
            count: stats.todayDeliveries,
          ),
          _EarningsRow(
            label: context.l10nRider.timeThisWeek,
            earnings: stats.weekEarningsFormatted,
            count: stats.weekDeliveries,
          ),
          _EarningsRow(
            label: context.l10nRider.timeThisMonth,
            earnings: stats.monthEarningsFormatted,
            count: stats.monthDeliveries,
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10nRider.avgPerTrip,
                style: TextStyle(
                  color: brand.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${stats.avgEarningsPerDelivery.toStringAsFixed(2)} zł',
                style: TextStyle(
                  color: brand.success,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EarningsRow extends StatelessWidget {
  final String label, earnings;
  final int count;
  const _EarningsRow({
    required this.label,
    required this.earnings,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: brand.primaryDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            context.l10nRider.ordersCount(count),
            style: TextStyle(fontSize: 12, color: brand.primaryDark),
          ),
          const SizedBox(width: 12),
          Text(
            earnings,
            style: TextStyle(fontWeight: FontWeight.w700, color: brand.primary),
          ),
        ],
      ),
    );
  }
}

// --- Settings Section ---
class _SettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            context.l10nRider.settingsTitle,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: brand.cardSurface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: brand.primaryDark!.withValues(alpha: 0.05),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _SettingsTile(
                icon: Icons.notifications_none_rounded,
                label: context.l10nRider.settingsNotifications,
                onTap: () {},
              ),
              ThemeSwitchTile(),
              _SettingsTile(
                icon: Icons.security_rounded,
                label: context.l10nRider.settingsPrivacy,
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.headset_mic_outlined,
                label: context.l10nRider.settingsHelp,
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.info_outline_rounded,
                label: context.l10nRider.settingsAppVersion,
                trailing: Text(
                  '1.0.0',
                  style: TextStyle(color: brand.primaryDark),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// --- Internal Reusable Widgets ---
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;

    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: brand.primary, size: 22),
      title: Text(
        label,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      trailing:
          trailing ??
          Icon(Icons.chevron_right_rounded, color: brand.primaryDark),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    );
  }
}

class ThemeSwitchTile extends StatelessWidget {
  const ThemeSwitchTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final bool isCurrentlyDark =
            themeProvider.themeMode == ThemeMode.dark ||
            (themeProvider.themeMode == ThemeMode.system &&
                MediaQuery.platformBrightnessOf(context) == Brightness.dark);

        return _SettingsTile(
          icon: isCurrentlyDark
              ? Icons.dark_mode_rounded
              : Icons.light_mode_rounded,
          label: context.l10nRider.settingsDarkMode,
          // Use the trailing property to host the switch
          trailing: Switch.adaptive(
            value: isCurrentlyDark,
            onChanged: (bool value) {
              themeProvider.toggle(context);
            },
          ),
          // Ensure tapping the whole tile also toggles the theme
          onTap: () => themeProvider.toggle(context),
        );
      },
    );
  }
}
