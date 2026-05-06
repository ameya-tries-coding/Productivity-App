import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
enum TaskType {
  @HiveField(0)
  oneTime,
  @HiveField(1)
  repeating,
}

@HiveType(typeId: 3)
enum RepeatType {
  @HiveField(0)
  none,
  @HiveField(1)
  daily,
  @HiveField(2)
  weekly,
  @HiveField(3)
  customInterval,
}

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  String? description;
  
  @HiveField(3)
  String? listId;
  
  @HiveField(4)
  late DateTime createdAt;

  @HiveField(5)
  DateTime? dueDate;

  @HiveField(6)
  late TaskType type;

  @HiveField(7)
  late RepeatType repeatType;

  @HiveField(8)
  List<int>? repeatDays; 
  
  @HiveField(9)
  int? customIntervalDays;
}
