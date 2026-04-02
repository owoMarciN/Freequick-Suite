import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/models/rider_model.dart';
import 'package:rider_app/providers/rider_provider.dart';
import 'package:rider_app/providers/rider_stats_provider.dart';
import 'package:rider_app/utils/app_theme.dart';
import 'package:rider_app/widgets/rider_stats_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('My Profile'),
        elevation: 0,
        backgroundColor: AppTheme.background,
        automaticallyImplyLeading: false,
        actions: [
          TextButton.icon(
            onPressed: () => _confirmSignOut(context),
            icon: const Icon(Icons.logout_rounded, size: 18, color: AppTheme.danger),
            label: const Text('Sign Out', style: TextStyle(color: AppTheme.danger, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer2<RiderProvider, RiderStatsProvider>(
        builder: (context, provider, stats, _) {
          final rider = provider.rider;
          if (rider == null || stats.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AppTheme.primary));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                _ProfileHeader(rider: rider),
                const SizedBox(height: 24),
                _StatsGrid(rider: rider, stats: stats, isOnline: provider.isOnline),
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

  void _confirmSignOut(BuildContext context) {
    final riderProvider = Provider.of<RiderProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Sign Out', style: TextStyle(fontWeight: FontWeight.w800)),
        content: const Text('Are you sure you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppTheme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              riderProvider.signOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.danger,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Sign Out', style: TextStyle(color: Colors.white)),
          ),
        ],
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
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.primary, AppTheme.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Center(
            child: Text(
              rider.name.isNotEmpty ? rider.name[0].toUpperCase() : 'R',
              style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          rider.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
        ),
        Text(
          rider.phone,
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14, fontWeight: FontWeight.w500),
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
  const _StatsGrid({required this.rider, required this.stats, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatCard(
          label: 'Deliveries',
          color: AppTheme.primary,
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
          label: 'Rating',
          color: AppTheme.warning,
          value: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star_rounded, size: 16),
              const SizedBox(width: 4),
              Text(stats.totalRatings > 0 ? stats.avgDriverRating.toStringAsFixed(1) : '—'),
            ],
          ),
        ),
        const SizedBox(width: 12),
        StatCard(
          label: 'Vehicle',
          color: AppTheme.info,
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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.divider.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Performance Summary',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppTheme.textPrimary)),
          const SizedBox(height: 20),
          _EarningsRow(label: 'Today', earnings: stats.todayEarningsFormatted, count: stats.todayDeliveries),
          _EarningsRow(label: 'This Week', earnings: stats.weekEarningsFormatted, count: stats.weekDeliveries),
          _EarningsRow(label: 'This Month', earnings: stats.monthEarningsFormatted, count: stats.monthDeliveries),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Avg. per trip', style: TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.w500)),
              Text(
                '${stats.avgEarningsPerDelivery.toStringAsFixed(2)} zł',
                style: const TextStyle(color: AppTheme.accent, fontWeight: FontWeight.w800, fontSize: 16),
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
  const _EarningsRow({required this.label, required this.earnings, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text('$count orders', style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
          const SizedBox(width: 12),
          Text(earnings, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
        ],
      ),
    );
  }
}

// --- Settings Section ---
class _SettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text('Settings', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.cardBg,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppTheme.divider.withValues(alpha: 0.5)),
          ),
          child: Column(
            children: [
              _SettingsTile(icon: Icons.notifications_none_rounded, label: 'Notifications', onTap: () {}),
              _SettingsTile(icon: Icons.security_rounded, label: 'Privacy & Security', onTap: () {}),
              _SettingsTile(icon: Icons.headset_mic_outlined, label: 'Help Center', onTap: () {}),
              _SettingsTile(
                icon: Icons.info_outline_rounded,
                label: 'App Version',
                trailing: const Text('1.0.0', style: TextStyle(color: AppTheme.textSecondary)),
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

  const _SettingsTile({required this.icon, required this.label, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppTheme.textPrimary, size: 22),
      title: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      trailing: trailing ?? const Icon(Icons.chevron_right_rounded, color: AppTheme.textSecondary),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    );
  }
}