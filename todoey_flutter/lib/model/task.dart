import 'package:flutter/cupertino.dart';

class Task {
  final String taskName;
  final bool isCompleted;

  Task({@required this.taskName, this.isCompleted = false});

  Task copyWith({String taskName, bool isCompleted}) {
    return Task(
      taskName: taskName ?? this.taskName,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}