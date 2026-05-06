import 'package:hive/hive.dart';

part 'task_completion.g.dart';

@HiveType(typeId: 4)
class TaskCompletion extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String taskId;

  @HiveField(2)
  late DateTime date;

  @HiveField(3)
  bool isCompleted = true;
}
