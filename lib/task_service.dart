import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class Task {
  final String id;
  final String name;
  final String description;
  bool isDone;

  Task({
    required this.id,
    required this.name,
    required this.description,
    this.isDone = false,
  });

  Task copyWith({bool? isDone}) {
    return Task(
      id: id,
      name: name,
      description: description,
      isDone: isDone ?? this.isDone,
    );
  }
}

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  final _uuid = const Uuid();

  // Add a new task with validation
  void addTask(String name, String description) {
    if (name.isEmpty || description.isEmpty) {
      throw ArgumentError("Task name and description cannot be empty");
    }

    final newTask = Task(id: _uuid.v4(), name: name, description: description);
    state = [...state, newTask];
  }

  // Remove a task by its ID
  void removeTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }

  // Toggle task completion status
  void toggleTaskStatus(String id) {
    final index = state.indexWhere((task) => task.id == id);
    if (index != -1) {
      final task = state[index];
      state = [
        ...state.sublist(0, index),
        task.copyWith(isDone: !task.isDone),
        ...state.sublist(index + 1)
      ];
    }
  }
}

// The provider for the TaskNotifier
final taskNotifierProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
