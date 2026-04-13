import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/providers/rider_provider.dart';
import 'package:rider_app/providers/rider_stats_provider.dart';
import 'package:rider_app/test/test_function_sheet.dart';
import 'package:rider_app/utils/app_theme.dart';
import 'package:rider_app/widgets/sheets/job_request_sheet.dart';
import 'package:rider_app/widgets/stats/rider_stats_widgets.dart';
import 'package:rider_app/screens/active_delivery_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _lastJobId;
  bool _jobSheetOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      // Using MultiProvider local to this builder to access both providers easily
      body: Consumer2<RiderProvider, RiderStatsProvider>(
        builder: (context, riderProvider, statsProvider, _) {
          final job = riderProvider.pendingJob;
          final activeOrder = riderProvider.activeOrder;

          if (job != null && job.id != _lastJobId && !_jobSheetOpen) {
            _lastJobId = job.id;
            _jobSheetOpen = true;

            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (!mounted) return;
              await _showJobRequest(context, riderProvider);

              if (mounted) {
                setState(() {
                  _jobSheetOpen = false;
                });
              }
            });
          }

          if (job == null) {
            _lastJobId = null;
          }

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 8),
                    _StatusToggle(provider: riderProvider),

                    if (activeOrder != null) ...[
                      const SizedBox(height: 16),
                      _ActiveOrderCard(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ActiveDeliveryScreen()),
                          );
                        },
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Test Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => const TestFunctionsSheet(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text("Test Cloud Functions",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),

                    const SizedBox(height: 24),
                    // Using shared EarningsCard
                    EarningsCard(provider: riderProvider),

                    const SizedBox(height: 24),
                    // Updated Stats Row passing the stats provider
                    _StatsRow(provider: riderProvider, stats: statsProvider),

                    const SizedBox(height: 24),
                    _RecentActivity(),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showJobRequest(BuildContext context, RiderProvider provider) {
    // 2. Add the 'return' keyword here!
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => JobRequestSheet(
        job: provider.pendingJob!,
        onAccept: () async {
          final jobId = provider.pendingJob?.id;
          if (jobId == null) return;
          Navigator.pop(context);
          await provider.acceptJob(jobId);
        },
        onReject: () async {
          final jobId = provider.pendingJob?.id;
          if (jobId == null) return;
          Navigator.pop(context);
          await provider.rejectJob(jobId);
        },
      ),
    );
  }
}

class _ActiveOrderCard extends StatelessWidget {
  final VoidCallback onTap;

  const _ActiveOrderCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // Using a gradient or distinct color to make it pop
          gradient: LinearGradient(
            colors: [AppTheme.primary, AppTheme.primary.withValues(alpha: 0.8)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.directions_bike_rounded,
                  color: Colors.white),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active Delivery',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Tap to return to map & navigation',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}

class _StatusToggle extends StatelessWidget {
  final RiderProvider provider;
  const _StatusToggle({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: provider.isOnline
            ? AppTheme.primary.withValues(alpha: 0.1)
            : AppTheme.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: provider.isOnline
              ? AppTheme.primary.withValues(alpha: 0.3)
              : AppTheme.divider,
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                provider.isOnline ? 'You\'re Online' : 'You\'re Offline',
                style: TextStyle(
                  color: provider.isOnline
                      ? AppTheme.primary
                      : AppTheme.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                provider.isOnline
                    ? 'Ready to receive orders'
                    : 'Go online to receive orders',
                style: const TextStyle(
                    color: AppTheme.textSecondary, fontSize: 13),
              ),
            ],
          ),
          const Spacer(),
          Transform.scale(
            scale: 1.2,
            child: Switch.adaptive(
              value: provider.isOnline,
              onChanged:
                  provider.isLoading ? null : (_) => provider.toggleOnline(),
              activeThumbColor: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final RiderProvider provider;
  final RiderStatsProvider stats;
  const _StatsRow({required this.provider, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Rating from Stats Provider
        StatCard(
          label: 'Rating',
          value: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star_rounded, color: AppTheme.warning, size: 18),
              const SizedBox(width: 4),
              Text(
                stats.totalRatings > 0
                    ? stats.avgDriverRating.toStringAsFixed(1)
                    : '—',
              ),
            ],
          ),
          color: AppTheme.warning,
        ),
        const SizedBox(width: 12),

        // Vehicle using helper from shared widgets
        StatCard(
          label: 'Vehicle',
          value: buildVehicleWidget(provider.rider?.vehicleType ?? 'SCOOTER'),
          color: AppTheme.info,
        ),
        const SizedBox(width: 12),

        // Status indicator
        StatCard(
          label: 'Status',
          value: _buildStatusIndicator(provider.isOnline),
          color: provider.isOnline ? AppTheme.primary : AppTheme.textSecondary,
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(bool isOnline) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isOnline ? Colors.green : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(isOnline ? 'Online' : 'Offline'),
      ],
    );
  }
}

class _RecentActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Activity',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 16)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.cardBg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Column(
              children: [
                Icon(Icons.history, color: AppTheme.textSecondary, size: 36),
                SizedBox(height: 8),
                Text('No recent deliveries',
                    style:
                        TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
                SizedBox(height: 4),
                Text('Go online to start receiving jobs',
                    style:
                        TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
