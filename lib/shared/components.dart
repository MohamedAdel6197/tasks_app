import 'package:flutter/material.dart';
import 'package:tasks_app/shared/cubit/cubit.dart';

Widget taskItemList(Map dataModel, context) => Dismissible(
      key: Key(dataModel['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteDataInDB(id: dataModel['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables

          children: [
            // ignore: prefer_const_constructors

            CircleAvatar(
              radius: 40.0,

              backgroundColor: Colors.blue,

              // ignore: prefer_const_constructors

              child: Text(
                "${dataModel['timeTask']}",

                // ignore: prefer_const_constructors

                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(
              width: 5.0,
            ),

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${dataModel['titleTask']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.only(top: 8.0, start: 8.0),
                    child: Text(
                      "${dataModel['dateTask']}",
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(
              width: 10.0,
            ),

            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateDataInDB(id: dataModel['id'], status: "Done");
                },
                icon: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 32.0,
                )),

            const SizedBox(
              width: 3.0,
            ),

            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateDataInDB(id: dataModel['id'], status: "Archived");
                },
                icon: const Icon(
                  Icons.archive_outlined,
                  color: Colors.grey,
                  size: 36.0,
                )),

            const SizedBox(
              width: 5.0,
            )
          ],
        ),
      ),
    );

Widget tasksBuilder({required List newTasksList}) => ListView.separated(
    itemBuilder: (context, index) => taskItemList(newTasksList[index], context),
    separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.black12,
          ),
        ),
    itemCount: newTasksList.length);

Widget emptyListScreen() => const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 150.0,
            color: Colors.grey,
          ),
          Text(
            "List is empty , No Tasks Avaiblie",
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                color: Colors.black54),
          ),
        ],
      ),
    );
