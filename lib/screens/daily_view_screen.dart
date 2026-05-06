import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/daily_tasks_provider.dart';
import '../providers/completions_provider.dart';

class DailyViewScreen extends ConsumerStatefulWidget {
  const DailyViewScreen({super.key});

  @override
  ConsumerState<DailyViewScreen> createState() => _DailyViewScreenState();
}

class _DailyViewScreenState extends ConsumerState<DailyViewScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(dailyTasksProvider(_selectedDate));
    final completionsAsync = ref.watch(dailyCompletionsProvider(_selectedDate));

    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('EEEE, MMM d').format(_selectedDate)),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                setState(() {
                  _selectedDate = picked;
                });
              }
            },
          ),
        ],
      ),
      body: tasksAsync.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return const Center(child: Text('No tasks for this day.'));
          }

          return completionsAsync.when(
            data: (completions) {
              final completedTaskIds = completions.map((c) => c.taskId).toSet();

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final isDone = completedTaskIds.contains(task.id);

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Checkbox(
                        value: isDone,
                        onChanged: (val) {
                          ref
                              .read(dailyCompletionsProvider(_selectedDate).notifier)
                              .toggleCompletion(task.id, _selectedDate);
                        },
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: isDone ? TextDecoration.lineThrough : null,
                          color: isDone ? Colors.grey : null,
                        ),
                      ),
                      subtitle: task.description != null 
                          ? Text(task.description!) 
                          : null,
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error loading completions: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error loading tasks: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Open Add Task Modal
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
