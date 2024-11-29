import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_service.dart';
import 'task_status_screen.dart';

class TaskManagerScreen extends ConsumerWidget {
  TaskManagerScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskNotifierProvider);
    
    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Manager',
          style: TextStyle(fontSize: 24), // Adjust app bar title size
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Horizontal padding
        child: Column(
          children: [
            // Task Name TextField
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            SizedBox(height: screenHeight * 0.02), // Dynamic space between inputs

            // Description TextField
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: screenHeight * 0.03), // Dynamic space before button

            // Add Task Button
            SizedBox(
              width: screenWidth * 0.8, // Adjust width to 80% of the screen
              child: ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  final description = descriptionController.text;

                  if (name.isNotEmpty && description.isNotEmpty) {
                    ref.read(taskNotifierProvider.notifier).addTask(name, description);
                    nameController.clear();
                    descriptionController.clear();
                  }
                },
                child: Text(
                  'Add Task',
                  style: TextStyle(fontSize: 18), // Adjust button font size
                ),
              ),
            ),
            SizedBox(height: 16), // Space before ListView

            // Expanded ListView of Tasks
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(
                      task.name,
                      style: TextStyle(fontSize: 24), // Adjust task name font size
                    ),
                    subtitle: Text(
                      task.description,
                      style: TextStyle(fontSize: 20), // Adjust task description font size
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, size: 28), // Adjust icon size
                      onPressed: () {
                        ref.read(taskNotifierProvider.notifier).removeTask(task.id);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskStatusScreen(task: task),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
