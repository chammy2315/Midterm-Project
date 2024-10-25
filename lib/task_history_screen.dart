// lib/task_history_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_service.dart';

class TaskHistoryScreen extends ConsumerWidget {
  const TaskHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskNotifierProvider);
    final completedTasks = tasks.where((task) => task.isDone).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Task History')),
      body: completedTasks.isEmpty
          ? const Center(child: Text('No tasks marked as done.'))
          : ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];
                return ListTile(
                  title: Text(task.name),
                  subtitle: Text(task.description),
                );
              },
            ),
    );
  }
}
