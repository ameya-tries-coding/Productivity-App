import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/database_service.dart';

part 'heatmap_provider.g.dart';

@riverpod
class HeatmapStats extends _$HeatmapStats {
  @override
  Future<Map<DateTime, int>> build() async {
    final allCompletions = DatabaseService.completionsBox.values.toList();

    final Map<DateTime, int> heatmapData = {};
    for (var completion in allCompletions) {
      if (completion.isCompleted) {
        heatmapData[completion.date] = (heatmapData[completion.date] ?? 0) + 1;
      }
    }

    return heatmapData;
  }
}
