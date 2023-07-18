import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_app/modules/archived_tasks.dart';
import 'package:tasks_app/modules/done_tasks.dart';
import 'package:tasks_app/modules/tasks_screen.dart';

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

  int currentScreen = 0;
  IconData icon = Icons.edit;
  Database? database;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title[currentScreen]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(icon),
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
}
