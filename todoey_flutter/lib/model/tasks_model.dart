import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:todoey_flutter/model/task.dart';

class TasksModel with ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      taskName: 'Task 1',
      isCompleted: false,
    ),
    Task(
      taskName: 'Task 2',
      isCompleted: true,
    ),
    Task(
      taskName: 'Task 3',
      isCompleted: false,
    ),
  ];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  void toggleStatus(int index) {
    final selectedTask = _tasks[index];

    final newTask = selectedTask.copyWith(
      isCompleted: !selectedTask.isCompleted,
    );

    _tasks.removeAt(index);
    _tasks.insert(index, newTask);

    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}