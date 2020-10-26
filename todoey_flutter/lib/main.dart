import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/model/tasks_model.dart';
import 'package:todoey_flutter/screens/task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksModel(),
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
