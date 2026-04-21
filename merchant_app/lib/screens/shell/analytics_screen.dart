import 'package:flutter/material.dart';
import 'package:merchant_app/providers/local_stats_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_assets/extensions/extensions.dart';
import 'package:shared_assets/widgets/ui/progress_bar.dart';
import 'package:merchant_app/widgets/ui/revenue_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int _rangeDays = 7;

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<LocalStatsProvider>();
    final brandColors = Theme.of(context).extension<BrandColors>()!;
    final colorScheme = Theme.of(context).colorScheme;

    if (stats.isLoading) {
      return Center(child: circularProgress());
    }

    final revenueData = stats.revenueForRange(_rangeDays);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel(
              context.l10nMerchant.analytics_section_glance, brandColors),
          const SizedBox(height: 14),
          LayoutBuilder(builder: (context, constraints) {
            final int cols = constraints.maxWidth > 500 ? 4 : 2;
            return GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                mainAxisExtent: 96,
              ),
              children: [
                _StatCard(
                  label:
                      context.l10nMerchant.analytics_stat_revenue(_rangeDays),
                  value: '${stats.last30dRevenue.toStringAsFixed(2)} PLN',
                  icon: Icons.payments_rounded,
                  color: brandColors.success!,
                  colorScheme: colorScheme,
                ),
                _StatCard(
                  label: context.l10nMerchant.analytics_stat_orders(_rangeDays),
                  value: '${stats.last30dOrders}',
                  icon: Icons.shopping_bag_rounded,
                  color: brandColors.muted!,
                  colorScheme: colorScheme,
                ),
                _StatCard(
                  label: context.l10nMerchant.analytics_stat_today,
                  value: '${stats.todayRevenue.toStringAsFixed(2)} PLN',
                  icon: Icons.today_rounded,
                  color: const Color(0xFF8B5CF6),
                  colorScheme: colorScheme,
                ),
                _StatCard(
                  label: context.l10nMerchant.analytics_stat_avg,
                  value: '${stats.avgOrderValue.toStringAsFixed(2)} PLN',
                  icon: Icons.trending_up_rounded,
                  color: const Color(0xFFD97706),
                  colorScheme: colorScheme,
                ),
              ],
            );
          }),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: _sectionLabel(
                  context.l10nMerchant.analytics_section_revenue,
                  brandColors,
                ),
              ),
              _RangeToggle(
                selected: _rangeDays,
                onChanged: (v) {
                  setState(() => _rangeDays = v);
                },
                brandColors: brandColors,
                colorScheme: colorScheme,
              ),
            ],
          ),
          const SizedBox(height: 14),
          RevenueChart(
            data: revenueData,
            brandColors: brandColors,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 32),
          _sectionLabel(
              context.l10nMerchant.analytics_section_status, brandColors),
          const SizedBox(height: 14),
          _StatusBreakdown(
            counts: stats.statusCounts,
            total: stats.totalOrders,
            brandColors: brandColors,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 32),
          _sectionLabel(
              context.l10nMerchant.analytics_section_popular, brandColors),
          const SizedBox(height: 14),
          _PopularItems(
            itemCounts: stats.itemCounts,
            brandColors: brandColors,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text, BrandColors brandColors) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        color: brandColors.muted,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _RangeToggle extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;
  final BrandColors brandColors;
  final ColorScheme colorScheme;

  const _RangeToggle({
    required this.selected,
    required this.onChanged,
    required this.brandColors,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [7, 30].map((days) {
        final isSelected = selected == days;
        return GestureDetector(
          onTap: () => onChanged(days),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: isSelected ? brandColors.muted : Colors.transparent,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: colorScheme.outline),
            ),
            child: Text(
              '${days}d',
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : brandColors.muted,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _StatusBreakdown extends StatelessWidget {
  final Map<String, int> counts;
  final int total;
  final BrandColors brandColors;
  final ColorScheme colorScheme;

  const _StatusBreakdown({
    required this.counts,
    required this.total,
    required this.brandColors,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    if (total == 0) return const SizedBox();

    return Column(
      children: counts.entries.map((e) {
        final pct = e.value / total;
        return ListTile(
          title: Text(e.key),
          trailing: Text('${e.value}'),
          subtitle: LinearProgressIndicator(value: pct),
        );
      }).toList(),
    );
  }
}

class _PopularItems extends StatelessWidget {
  final Map<String, int> itemCounts;
  final BrandColors brandColors;
  final ColorScheme colorScheme;

  const _PopularItems({
    required this.itemCounts,
    required this.brandColors,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final sorted = (itemCounts.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value)))
        .take(5);

    return Column(
      children: sorted.map((e) {
        return ListTile(
          title: Text(e.key),
          trailing: Text('${e.value}'),
        );
      }).toList(),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  final ColorScheme colorScheme;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}
