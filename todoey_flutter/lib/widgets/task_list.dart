import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/model/tasks_model.dart';
import 'package:todoey_flutter/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TasksModel>(context);

    return ListView.builder(
      itemCount: model.tasks.length,
      itemBuilder: (context, index) {
        final task = model.tasks[index];

        return TaskTile(
          task: task.taskName,
          isCompleted: task.isCompleted,
          onCheck: (isChecked) => model.toggleStatus(index),
          onLongPress: () => model.removeTask(index),
        );
      },
    );
  }
}
