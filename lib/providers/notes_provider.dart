import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/database_service.dart';
import '../models/note.dart';

part 'notes_provider.g.dart';

@riverpod
class Notes extends _$Notes {
  @override
  Future<List<Note>> build() async {
    return _fetchNotes();
  }

  Future<List<Note>> _fetchNotes() async {
    return DatabaseService.notesBox.values.toList();
  }

  Future<void> addNote(String title, String body, {String? taskId, List<String>? tags}) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final note = Note()
      ..id = id
      ..title = title
      ..body = body
      ..taskId = taskId
      ..tags = tags ?? []
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();

    await DatabaseService.notesBox.put(id, note);
    state = AsyncValue.data(await _fetchNotes());
  }

  Future<void> updateNote(String id, String title, String body, {List<String>? tags}) async {
    final note = DatabaseService.notesBox.get(id);
    if (note != null) {
      note.title = title;
      note.body = body;
      if (tags != null) note.tags = tags;
      note.updatedAt = DateTime.now();
      await DatabaseService.notesBox.put(id, note);
    }
    state = AsyncValue.data(await _fetchNotes());
  }

  Future<void> deleteNote(String id) async {
    await DatabaseService.notesBox.delete(id);
    state = AsyncValue.data(await _fetchNotes());
  }
}
