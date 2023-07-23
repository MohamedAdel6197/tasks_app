import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/layouts/home_screen.dart';
import 'package:tasks_app/shared/bloc_observer.dart';

void main() {
  runApp(const TasksAPP());
}

class TasksAPP extends StatelessWidget {
  const TasksAPP({super.key});

  @override
  Widget build(BuildContext context) {
    Bloc.observer = MyBlocObserver();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
