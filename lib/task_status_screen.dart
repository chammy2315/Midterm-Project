// lib/task_status_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_service.dart';

class TaskStatusScreen extends ConsumerWidget {
  final Task task;

  const TaskStatusScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(task.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description:', style: Theme.of(context).textTheme.bodyLarge),
            Text(task.description),
            const SizedBox(height: 20),
            Text(
              'Status: ${task.isDone ? "Done" : "On Going"}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: task.isDone ? Colors.green : Colors.orange,
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ref.read(taskNotifierProvider.notifier).toggleTaskStatus(task.id);
                  Navigator.pop(context);
                },
                child: Text(task.isDone ? 'Mark as On Going' : 'Mark as Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
