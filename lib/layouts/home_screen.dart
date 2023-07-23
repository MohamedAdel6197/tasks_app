import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/shared/cubit/cubit.dart';
import 'package:tasks_app/shared/cubit/states.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   super.initState();
  //   createDB();
  // }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDB(),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.title[cubit.currentScreen]),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: FloatingActionButton(
                onPressed: () {
                  //insertIntoDB();
                  if (cubit.isSheetOpen) {
                    cubit.changeFABIcon(isOpen: false, iconData: Icons.add);
                    Navigator.pop(context);
                    // setState(() {
                    //   icon = Icons.add;
                    // });
                    //isSheetOpen = !isSheetOpen;
                  } else {
                    scaffoldKey.currentState
                        ?.showBottomSheet((context) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 232, 232, 236),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(15.0),
                                  )),
                              // ignore: prefer_const_constructors
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const SizedBox(
                                      height: 40.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: TextFormField(
                                        controller: titleController,
                                        decoration: const InputDecoration(
                                          labelText: "Task Title",
                                          prefixIcon: Icon(Icons.title),
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value == "") {
                                            return "task title must not be empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: TextFormField(
                                        controller: dateController,
                                        decoration: const InputDecoration(
                                          labelText: "Task Date",
                                          prefixIcon: Icon(
                                              Icons.calendar_month_outlined),
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value == "") {
                                            return "task Date must not be empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onTap: () {
                                          dateController.text = "";
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.parse(
                                                      "2022-12-30"),
                                                  lastDate: DateTime.parse(
                                                      "2050-12-30"))
                                              .then((value) {
                                            dateController.text =
                                                DateFormat.yMMMMd()
                                                    .format(value!);
                                          });
                                        },
                                        keyboardType: TextInputType.none,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: TextFormField(
                                        controller: timeController,
                                        decoration: const InputDecoration(
                                          labelText: "Task Time",
                                          prefixIcon:
                                              Icon(Icons.timelapse_outlined),
                                          border: OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.none,
                                        validator: (value) {
                                          if (value == "") {
                                            return "task time must not be empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onTap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) {
                                            timeController.text = value!
                                                .format(context)
                                                .toString();
                                          }).catchError((onError) {
                                            // ignore: avoid_print
                                            print(onError);
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: TextButton(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                // insertIntoDB(
                                                //         title: titleController
                                                //             .text,
                                                //         date: dateController
                                                //             .text,
                                                //         time: timeController
                                                //             .text)
                                                //     .then((value) {})
                                                //     .catchError((onError) {
                                                //   // ignore: avoid_print
                                                //   print("error $onError");
                                                // });
                                                cubit.insertIntoDB(
                                                    title: titleController.text,
                                                    date: dateController.text,
                                                    time: timeController.text);
                                                titleController.text = "";
                                                dateController.text = "";
                                                timeController.text = "";
                                              }
                                            },
                                            child: const Text(
                                              "Add Task",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 32.0),
                                            ),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                        .closed
                        .then((value) {
                          cubit.changeFABIcon(
                              isOpen: false, iconData: Icons.add);
                          //done edit
                          // setState(() {
                          //   icon = Icons.add;
                          // });
                          //isSheetOpen = !isSheetOpen;
                        });
                    cubit.changeFABIcon(
                        isOpen: true, iconData: Icons.arrow_drop_down_outlined);
                    //done edit
                    // setState(() {
                    //   icon = Icons.arrow_drop_down_outlined;
                    // });
                    //isSheetOpen = !isSheetOpen;
                  }
                },
                child: Icon(cubit.icon),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle), label: "Done Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: "Archived Tasks"),
              ],
              currentIndex: cubit.currentScreen,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                //done edit
                // setState(() {
                //   currentScreen = value;
                // });
                cubit.changeCurrentIndexScreen(index: value);
              },
            ),
            body: ConditionalBuilder(
              condition: cubit.newtasksTb.isNotEmpty,
              builder: (context) => cubit.screens[cubit.currentScreen],
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        },
        listener: (context, state) {
          if (state is InsertIntoDBlState) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
  
// }
