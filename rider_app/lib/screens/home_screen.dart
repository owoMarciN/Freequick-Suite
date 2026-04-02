import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/providers/rider_provider.dart';
import 'package:rider_app/providers/rider_stats_provider.dart'; // Ensure this is imported
import 'package:rider_app/test/test_function_sheet.dart';
import 'package:rider_app/utils/app_theme.dart';
import 'package:rider_app/widgets/job_request_sheet.dart';
import 'package:rider_app/widgets/rider_stats_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _lastJobId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      // Using MultiProvider local to this builder to access both providers easily
      body: Consumer2<RiderProvider, RiderStatsProvider>(
        builder: (context, riderProvider, statsProvider, _) {
          final job = riderProvider.pendingJob;

          // Logic for showing job requests
          if (job != null && job.id != _lastJobId) {
            _lastJobId = job.id;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showJobRequest(context, riderProvider);
            });
          }

          if (job == null) {
            _lastJobId = null;
          }

          return CustomScrollView(
            slivers: [
              _buildAppBar(context, riderProvider),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 8),
                    _StatusToggle(provider: riderProvider),
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

  void _showJobRequest(BuildContext context, RiderProvider provider) {
    showModalBottomSheet(
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

  SliverAppBar _buildAppBar(BuildContext context, RiderProvider provider) {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      backgroundColor: AppTheme.surface,
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.delivery_dining, color: AppTheme.primary, size: 20),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                provider.rider?.name ?? 'Rider',
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: provider.isOnline ? AppTheme.primary : AppTheme.textSecondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    provider.isOnline ? 'Online' : 'Offline',
                    style: TextStyle(
                      color: provider.isOnline ? AppTheme.primary : AppTheme.textSecondary,
                      fontSize: 11,
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

class _StatusToggle extends StatelessWidget {
  final RiderProvider provider;
  const _StatusToggle({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: provider.isOnline ? AppTheme.primary.withValues(alpha: 0.1) : AppTheme.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: provider.isOnline ? AppTheme.primary.withValues(alpha: 0.3) : AppTheme.divider,
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
                  color: provider.isOnline ? AppTheme.primary : AppTheme.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                provider.isOnline ? 'Ready to receive orders' : 'Go online to receive orders',
                style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
              ),
            ],
          ),
          const Spacer(),
          Transform.scale(
            scale: 1.2,
            child: Switch.adaptive(
              value: provider.isOnline,
              onChanged: provider.isLoading ? null : (_) => provider.toggleOnline(),
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
              Text(stats.totalRatings > 0 
                ? stats.avgDriverRating.toStringAsFixed(1) 
                : '—',),
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
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
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
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
                SizedBox(height: 4),
                Text('Go online to start receiving jobs',
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}