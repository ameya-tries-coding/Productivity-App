import 'package:hive/hive.dart';

part 'task_list.g.dart';

@HiveType(typeId: 0)
class TaskList extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;
  
  @HiveField(2)
  int? colorValue;

  @HiveField(3)
  String? iconName;

  @HiveField(4)
  DateTime createdAt = DateTime.now();
}
