import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/database_service.dart';
import '../models/task_list.dart';

part 'lists_provider.g.dart';

@riverpod
class Lists extends _$Lists {
  @override
  Future<List<TaskList>> build() async {
    return _fetchLists();
  }

  Future<List<TaskList>> _fetchLists() async {
    return DatabaseService.listsBox.values.toList();
  }

  Future<void> addList(String name, {int? colorValue, String? iconName}) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final newList = TaskList()
      ..id = id
      ..name = name
      ..colorValue = colorValue
      ..iconName = iconName
      ..createdAt = DateTime.now();

    await DatabaseService.listsBox.put(id, newList);
    state = AsyncValue.data(await _fetchLists());
  }

  Future<void> deleteList(String id) async {
    await DatabaseService.listsBox.delete(id);
    state = AsyncValue.data(await _fetchLists());
  }
}
