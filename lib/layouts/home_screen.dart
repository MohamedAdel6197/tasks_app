import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_app/modules/archived_tasks.dart';
import 'package:tasks_app/modules/done_tasks.dart';
import 'package:tasks_app/modules/tasks_screen.dart';

import '../modules/sheet_view.dart';

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

  @override
  void initState() {
    super.initState();
    createDB();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSheetOpen = false;
  int currentScreen = 0;
  IconData icon = Icons.edit;
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
                icon = Icons.edit;
              });
              isSheetOpen = !isSheetOpen;
            } else {
              scaffoldKey.currentState
                  ?.showBottomSheet((context) => const SheetView());
              setState(() {
                icon = Icons.add;
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
      onOpen: (db) {
        // ignore: avoid_print
        print("database opened");
      },
    );
  }

  void insertIntoDB() {
    database!.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO Tasks( titleTask, dateTask , timeTask , statusTask ) '
              'VALUES ("Task1", "18/7", "4:05 PM" , "now")')
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
}
