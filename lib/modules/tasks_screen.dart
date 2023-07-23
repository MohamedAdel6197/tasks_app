import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/shared/components.dart';
import 'package:tasks_app/shared/cubit/cubit.dart';
import 'package:tasks_app/shared/cubit/states.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        List newTasks = AppCubit.get(context).newtasksTb;
        return tasksBuilder(newTasksList: newTasks);
      },
      listener: (context, state) {},
    );
  }
}

// class Tasks extends StatefulWidget {
//   const Tasks({super.key});

//   @override
//   State<Tasks> createState() => _TasksState();
// }

// class _TasksState extends State<Tasks> {
//   @override
//   Widget build(BuildContext context) {
//     return }
// }
