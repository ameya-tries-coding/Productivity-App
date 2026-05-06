import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 5)
class Note extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String body;

  @HiveField(3)
  String? taskId;

  @HiveField(4)
  List<String> tags = [];

  @HiveField(5)
  late DateTime createdAt;

  @HiveField(6)
  late DateTime updatedAt;
}
