import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_service.dart';

class TaskHistoryScreen extends ConsumerWidget {
  const TaskHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskNotifierProvider);
    final completedTasks = tasks.where((task) => task.isDone).toList();

    // Get screen width and height for dynamic sizing
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task History',
          style: TextStyle(fontSize: screenWidth * 0.05), // Adjust title font size based on screen width
        ),
      ),
      body: completedTasks.isEmpty
          ? Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Horizontal padding
                child: Text(
                  'No tasks marked as done.',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // Dynamically adjust font size
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01, // Dynamic vertical padding for list items
                      horizontal: screenWidth * 0.05), // Horizontal padding for list items
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // Vertical padding for ListTile
                    title: Text(
                      task.name,
                      style: TextStyle(fontSize: screenWidth * 0.05), // Adjust text size dynamically
                    ),
                    subtitle: Text(
                      task.description,
                      style: TextStyle(fontSize: screenWidth * 0.04), // Adjust subtitle text size dynamically
                    ),
                  ),
                );
              },
            ),
    );
  }
}
