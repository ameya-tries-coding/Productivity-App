import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/lists_provider.dart';

class ListsScreen extends ConsumerWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listsAsync = ref.watch(listsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Lists'),
      ),
      body: listsAsync.when(
        data: (lists) {
          if (lists.isEmpty) {
            return const Center(child: Text('No lists found. Create one!'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: lists.length,
            itemBuilder: (context, index) {
              final list = lists[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.list),
                  title: Text(list.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      ref.read(listsProvider.notifier).deleteList(list.id);
                    },
                  ),
                  onTap: () {
                    // TODO: Navigate to List Tasks view
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddListDialog(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddListDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New List'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'List Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  ref.read(listsProvider.notifier).addList(controller.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
