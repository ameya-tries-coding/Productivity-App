import '../models/task.dart';

class TaskLogicService {
  /// Determines if a given task is relevant for the specified date.
  static bool isTaskRelevantForDate(Task task, DateTime date) {
    // Normalize date to midnight for comparison
    final targetDate = DateTime(date.year, date.month, date.day);
    final createdAtDate = DateTime(task.createdAt.year, task.createdAt.month, task.createdAt.day);

    if (targetDate.isBefore(createdAtDate)) {
      return false; // Task didn't exist yet
    }

    if (task.type == TaskType.oneTime) {
      if (task.dueDate != null) {
        final dueDate = DateTime(task.dueDate!.year, task.dueDate!.month, task.dueDate!.day);
        return targetDate.isAtSameMomentAs(dueDate);
      }
      // If oneTime and no due date, maybe it's just always relevant until completed?
      // Or relevant only on creation date. For MVP, if no due date, we treat it as relevant on creation date.
      return targetDate.isAtSameMomentAs(createdAtDate);
    } else {
      // Repeating task
      switch (task.repeatType) {
        case RepeatType.none:
          return targetDate.isAtSameMomentAs(createdAtDate);
        case RepeatType.daily:
          return true;
        case RepeatType.weekly:
          if (task.repeatDays == null || task.repeatDays!.isEmpty) return false;
          // DateTime.weekday: 1 = Monday, 7 = Sunday
          return task.repeatDays!.contains(targetDate.weekday);
        case RepeatType.customInterval:
          if (task.customIntervalDays == null || task.customIntervalDays! <= 0) return false;
          final difference = targetDate.difference(createdAtDate).inDays;
          return difference % task.customIntervalDays! == 0;
      }
    }
  }
}
