import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String task;
  final bool isCompleted;
  final Function(bool) onCheck;
  final Function() onLongPress;

  TaskTile({
    this.task,
    this.isCompleted,
    @required this.onCheck,
    @required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPress,
      title: Text(
        task,
        style: TextStyle(
          decoration: isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: isCompleted,
        activeColor: Colors.lightBlueAccent,
        onChanged: (isChecked) => onCheck(isChecked),
      ),
    );
  }
}