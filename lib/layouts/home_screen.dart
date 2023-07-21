import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_app/modules/archived_tasks.dart';
import 'package:tasks_app/modules/done_tasks.dart';
import 'package:tasks_app/modules/tasks_screen.dart';
import 'package:tasks_app/shared/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> title = ["Tasks", "Done Tasks", "Archived Tasks"];
  List<Widget> screens = [
    const Tasks(),
    const DoneTasks(),
    const ArchivedTasks()
  ];

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    createDB();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSheetOpen = false;
  int currentScreen = 0;
  IconData icon = Icons.add;
  Database? database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(title[currentScreen]),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: FloatingActionButton(
          onPressed: () {
            //insertIntoDB();
            if (isSheetOpen) {
              Navigator.pop(context);
              setState(() {
                icon = Icons.add;
              });
              isSheetOpen = !isSheetOpen;
            } else {
              scaffoldKey.currentState
                  ?.showBottomSheet((context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                                    prefixIcon:
                                        Icon(Icons.calendar_month_outlined),
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
                                            firstDate:
                                                DateTime.parse("2022-12-30"),
                                            lastDate:
                                                DateTime.parse("2050-12-30"))
                                        .then((value) {
                                      dateController.text =
                                          DateFormat.yMMMMd().format(value!);
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
                                    prefixIcon: Icon(Icons.timelapse_outlined),
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
                                      timeController.text =
                                          value!.format(context).toString();
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
                                        if (formKey.currentState!.validate()) {
                                          insertIntoDB(
                                                  title: titleController.text,
                                                  date: dateController.text,
                                                  time: timeController.text)
                                              .then((value) {})
                                              .catchError((onError) {
                                            // ignore: avoid_print
                                            print("error $onError");
                                          });
                                          Navigator.pop(context);
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
                    setState(() {
                      icon = Icons.add;
                    });
                    isSheetOpen = !isSheetOpen;
                  });
              setState(() {
                icon = Icons.arrow_drop_down_outlined;
              });

              isSheetOpen = !isSheetOpen;
            }
          },
          child: Icon(icon),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle), label: "Done Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: "Archived Tasks"),
        ],
        currentIndex: currentScreen,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            currentScreen = value;
          });
        },
      ),
      body: screens[currentScreen],
    );
  }

  void createDB() async {
    database = await openDatabase(
      "tasksDB.db",
      version: 1,
      onCreate: (database, version) {
        // ignore: avoid_print
        print("database created");
        database
            .execute(
                'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, titleTask TEXT, dateTask TEXT ,timeTask TEXT , statusTask Text)')
            .then((value) {
          // ignore: avoid_print
          print("table created");
        }).catchError((onError) {
          // ignore: avoid_print, unnecessary_string_escapes
          print("can\'t create table $onError");
        });
      },
      onOpen: (database) {
        getDataFromDB(database).then((value) {
          setState(() {
            tasksTb = value;
          });
        });
        // ignore: avoid_print
        print("database opened");
      },
    );
  }

  Future insertIntoDB(
      {required String title,
      required String date,
      required String time}) async {
    return await database?.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO Tasks( titleTask, dateTask , timeTask , statusTask ) '
              'VALUES ("$title", "$date", "$time" , "now")')
          .then((value) {
        // ignore: avoid_print
        print("$value  row inserted");
      }).catchError((onError) {
        // ignore: avoid_print
        print("error when insert this row $onError");
      });
      return Future(() => null);
    });
  }

  Future<List<Map>> getDataFromDB(database) async {
    return await database.rawQuery("SELECT * FROM Tasks");
  }
}
