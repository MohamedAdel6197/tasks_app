import 'package:flutter/material.dart';
import 'package:tasks_app/layouts/home_screen.dart';

void main() {
  runApp(const TasksAPP());
}

class TasksAPP extends StatelessWidget {
  const TasksAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
