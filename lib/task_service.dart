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

  final _uuid = Uuid();

  void addTask(String name, String description) {
    final newTask = Task(id: _uuid.v4(), name: name, description: description);
    state = [...state, newTask];
  }

  void removeTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }

  void toggleTaskStatus(String id) {
    state = state.map((task) {
      return task.id == id ? task.copyWith(isDone: !task.isDone) : task;
    }).toList();
  }
}

final taskNotifierProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
