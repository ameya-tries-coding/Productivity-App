import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/database_service.dart';
import '../services/task_logic_service.dart';
import '../models/task.dart';

part 'daily_tasks_provider.g.dart';

@riverpod
class DailyTasks extends _$DailyTasks {
  @override
  Future<List<Task>> build(DateTime date) async {
    return _fetchTasksForDate(date);
  }

  Future<List<Task>> _fetchTasksForDate(DateTime targetDate) async {
    final allTasks = DatabaseService.tasksBox.values.toList();
    final relevantTasks = allTasks.where((task) {
      return TaskLogicService.isTaskRelevantForDate(task, targetDate);
    }).toList();
    return relevantTasks;
  }

  Future<void> addTask(Task task) async {
    await DatabaseService.tasksBox.put(task.id, task);
    state = AsyncValue.data(await _fetchTasksForDate(date));
  }

  Future<void> deleteTask(String id) async {
    await DatabaseService.tasksBox.delete(id);
    state = AsyncValue.data(await _fetchTasksForDate(date));
  }
}
