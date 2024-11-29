import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_service.dart';

class TaskStatusScreen extends ConsumerWidget {
  final Task task;

  const TaskStatusScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          task.name,
          style: TextStyle(fontSize: screenWidth * 0.05), // Adjust app bar title size
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Horizontal padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description Section
            Text(
              'Description:',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: screenWidth * 0.045, // Adjust font size dynamically
                  ),
            ),
            SizedBox(height: screenHeight * 0.01), // Dynamic space between description label and text
            Text(
              task.description,
              style: TextStyle(fontSize: screenWidth * 0.04), // Adjust font size dynamically
            ),
            SizedBox(height: screenHeight * 0.03), // Space before the Status text

            // Status Text
            Text(
              'Status: ${task.isDone ? "Done" : "On Going"}',
              style: TextStyle(
                fontSize: screenWidth * 0.05, // Adjust font size dynamically
                fontWeight: FontWeight.bold,
                color: task.isDone ? Colors.green : Colors.orange,
              ),
            ),
            const Spacer(), // Pushes button to the bottom

            // Centered Button
            Center(
              child: SizedBox(
                width: screenWidth * 0.8, // Button width is 80% of the screen width
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(taskNotifierProvider.notifier).toggleTaskStatus(task.id);
                    Navigator.pop(context);
                  },
                  child: Text(
                    task.isDone ? 'Mark as On Going' : 'Mark as Done',
                    style: TextStyle(fontSize: screenWidth * 0.045), // Adjust button font size
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
