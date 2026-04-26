import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/providers/rider_provider.dart';
import 'package:rider_app/providers/rider_stats_provider.dart';
import 'package:rider_app/test/test_function_sheet.dart';
import 'package:shared_assets/extensions/extensions.dart';
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
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
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
                                  const ActiveDeliveryScreen(),
                            ),
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
                        child: Text(
                          context.l10nCommon.testCloudFunctions,
                          style: TextStyle(color: Colors.white),
                        ),
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
    final brand = Theme.of(context).extension<BrandColors>()!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // Using a gradient or distinct color to make it pop
          gradient: LinearGradient(
            colors: [brand.primary!, brand.primary!.withValues(alpha: 0.8)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: brand.primary!.withValues(alpha: 0.3),
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
              child: const Icon(
                Icons.directions_bike_rounded,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10nRider.activeDelivery,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    context.l10nRider.tapToReturnToMap,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 18,
            ),
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
    final brand = Theme.of(context).extension<BrandColors>()!;
    final deviderColor = Theme.of(context).dividerColor;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: provider.isOnline
            ? brand.primary!.withValues(alpha: 0.1)
            : brand.cardSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: provider.isOnline
              ? brand.primary!.withValues(alpha: 0.3)
              : deviderColor,
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                provider.isOnline
                    ? context.l10nRider.youAreOnline
                    : context.l10nRider.youAreOffline,
                style: TextStyle(
                  color: provider.isOnline ? brand.primary : brand.primaryDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                provider.isOnline
                    ? context.l10nRider.statusReadyToReceive
                    : context.l10nRider.statusGoOnlineToReceive,
                style: TextStyle(color: brand.primaryDark, fontSize: 13),
              ),
            ],
          ),
          const Spacer(),
          Transform.scale(
            scale: 1.2,
            child: Switch.adaptive(
              value: provider.isOnline,
              onChanged: provider.isLoading
                  ? null
                  : (_) => provider.toggleOnline(),
              activeThumbColor: Colors.white,
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
    final brand = Theme.of(context).extension<BrandColors>()!;

    return Row(
      children: [
        // Rating from Stats Provider
        StatCard(
          label: context.l10nRider.statRating,
          value: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star_rounded, color: brand.warning, size: 18),
              const SizedBox(width: 4),
              Text(
                stats.totalRatings > 0
                    ? stats.avgDriverRating.toStringAsFixed(1)
                    : '—',
              ),
            ],
          ),
          color: brand.warning!,
        ),
        const SizedBox(width: 12),

        // Vehicle using helper from shared widgets
        StatCard(
          label: context.l10nRider.statVehicle,
          value: buildVehicleWidget(provider.rider?.vehicleType ?? 'SCOOTER'),
          color: brand.primary!,
        ),
        const SizedBox(width: 12),

        // Status indicator
        StatCard(
          label: context.l10nRider.statStatus,
          value: _buildStatusIndicator(provider.isOnline, context),
          color: provider.isOnline ? brand.success! : brand.danger!,
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(bool isOnline, BuildContext context) {
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
        Text(isOnline ? context.l10nRider.online : context.l10nRider.offline),
      ],
    );
  }
}

class _RecentActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brand = Theme.of(context).extension<BrandColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10nRider.recentActivityTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: brand.cardSurface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.history, color: brand.primaryDark, size: 36),
                SizedBox(height: 8),
                Text(
                  context.l10nRider.recentActivityEmptyTitle,
                  style: TextStyle(color: brand.primaryDark, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  context.l10nRider.recentActivityEmptySubtitle,
                  style: TextStyle(color: brand.primaryDark, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
