import 'package:hive_flutter/hive_flutter.dart';

import '../models/task_list.dart';
import '../models/task.dart';
import '../models/task_completion.dart';
import '../models/note.dart';

class DatabaseService {
  static late Box<TaskList> listsBox;
  static late Box<Task> tasksBox;
  static late Box<TaskCompletion> completionsBox;
  static late Box<Note> notesBox;

  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TaskListAdapter());
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(TaskTypeAdapter());
    Hive.registerAdapter(RepeatTypeAdapter());
    Hive.registerAdapter(TaskCompletionAdapter());
    Hive.registerAdapter(NoteAdapter());

    listsBox = await Hive.openBox<TaskList>('taskLists');
    tasksBox = await Hive.openBox<Task>('tasks');
    completionsBox = await Hive.openBox<TaskCompletion>('completions');
    notesBox = await Hive.openBox<Note>('notes');
  }
}
