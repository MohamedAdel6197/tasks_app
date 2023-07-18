import 'package:flutter/material.dart';
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
  int currentScreen = 0;
  IconData icon = Icons.edit;
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
}
