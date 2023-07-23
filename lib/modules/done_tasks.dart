import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class DoneTasks extends StatefulWidget {
  const DoneTasks({super.key});

  @override
  State<DoneTasks> createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        List doneTasks = AppCubit.get(context).donetasksTb;
        return ConditionalBuilder(
          condition: doneTasks.isNotEmpty,
          builder: (context) => tasksBuilder(newTasksList: doneTasks),
          fallback: (context) => emptyListScreen(),
        );
      },
      listener: (context, state) {},
    );
  }
}
