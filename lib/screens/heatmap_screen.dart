import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/heatmap_provider.dart';
import '../widgets/custom_heatmap.dart';

class HeatmapScreen extends ConsumerWidget {
  const HeatmapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heatmapDataAsync = ref.watch(heatmapStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Heatmap'),
      ),
      body: heatmapDataAsync.when(
        data: (data) {
          final now = DateTime.now();
          final endDate = DateTime(now.year, now.month, now.day);
          // Show last 60 days
          final startDate = endDate.subtract(const Duration(days: 60));

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Last 60 Days',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomHeatmap(
                    data: data,
                    startDate: startDate,
                    endDate: endDate,
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
