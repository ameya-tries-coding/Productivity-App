import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/database_service.dart';
import '../models/task_completion.dart';

part 'completions_provider.g.dart';

@riverpod
class DailyCompletions extends _$DailyCompletions {
  @override
  Future<List<TaskCompletion>> build(DateTime date) async {
    return _fetchCompletions(date);
  }

  Future<List<TaskCompletion>> _fetchCompletions(DateTime targetDate) async {
    final normalizedDate = DateTime(targetDate.year, targetDate.month, targetDate.day);
    return DatabaseService.completionsBox.values.where((c) => c.date == normalizedDate).toList();
  }

  Future<void> toggleCompletion(String taskId, DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    
    // Find existing completion
    TaskCompletion? existingCompletion;
    try {
      existingCompletion = DatabaseService.completionsBox.values.firstWhere(
        (c) => c.taskId == taskId && c.date == normalizedDate,
      );
    } catch (e) {
      // not found
    }

    if (existingCompletion != null) {
      // Toggle off
      await DatabaseService.completionsBox.delete(existingCompletion.id);
    } else {
      // Toggle on
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final completion = TaskCompletion()
        ..id = id
        ..taskId = taskId
        ..date = normalizedDate
        ..isCompleted = true;
      await DatabaseService.completionsBox.put(id, completion);
    }

    state = AsyncValue.data(await _fetchCompletions(date));
  }
}
