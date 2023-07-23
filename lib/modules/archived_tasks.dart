import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class ArchivedTasks extends StatefulWidget {
  const ArchivedTasks({super.key});

  @override
  State<ArchivedTasks> createState() => _ArchivedTasksState();
}

class _ArchivedTasksState extends State<ArchivedTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        List archivedTasks = AppCubit.get(context).archivedtasksTb;
        return ConditionalBuilder(
          condition: archivedTasks.isNotEmpty,
          builder: (context) => tasksBuilder(newTasksList: archivedTasks),
          fallback: (context) => emptyListScreen(),
        );
      },
      listener: (context, state) {},
    );
  }
}
