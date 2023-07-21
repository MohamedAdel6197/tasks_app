import 'package:flutter/material.dart';
import 'package:tasks_app/shared/components.dart';
import 'package:tasks_app/shared/constants.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return ListView.separated(
        itemBuilder: (context, index) => taskItemList(tasksTb[index]),
        separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.black12,
              ),
            ),
        itemCount: tasksTb.length);
  }
}
