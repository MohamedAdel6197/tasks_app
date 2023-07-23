import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_app/shared/cubit/states.dart';

import '../../modules/archived_tasks.dart';
import '../../modules/done_tasks.dart';
import '../../modules/tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  int currentScreen = 0;
  bool isSheetOpen = false;
  IconData icon = Icons.add;
  List<String> title = ["Tasks", "Done Tasks", "Archived Tasks"];
  List<Widget> screens = [
    const Tasks(),
    const DoneTasks(),
    const ArchivedTasks()
  ];
  Database? database;
  List<Map> newtasksTb = [];
  List<Map> donetasksTb = [];
  List<Map> archivedtasksTb = [];

  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  void changeCurrentIndexScreen({required int index}) {
    currentScreen = index;
    emit(ChangeCurrentIndexlState());
  }

  void changeFABIcon({required bool isOpen, required IconData iconData}) {
    isSheetOpen = isOpen;
    icon = iconData;
    emit(ChangeFABIconlState());
  }

  void createDB() {
    openDatabase("tasksDB.db", version: 1, onCreate: (database, version) {
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
    }, onOpen: (database) {
      getDataFromDB(database);
      // ignore: avoid_print
      print("database opened");
    }).then((value) {
      database = value;
      emit(CreateDBState());
    });
  }

  void insertIntoDB(
      {required String title,
      required String date,
      required String time}) async {
    await database?.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO Tasks( titleTask, dateTask , timeTask , statusTask ) '
              'VALUES ("$title", "$date", "$time" , "now")')
          .then((value) {
        // ignore: avoid_print
        print("$value  Row Inserted");
        emit(InsertIntoDBlState());
        getDataFromDB(database);
      }).catchError((onError) {
        // ignore: avoid_print
        print("error when insert this row $onError");
      });
      return Future(() => null);
    });
  }

  void getDataFromDB(database) async {
    newtasksTb = [];
    donetasksTb = [];
    archivedtasksTb = [];
    database.rawQuery("SELECT * FROM Tasks").then((value) {
      value.forEach((element) {
        if (element['statusTask'] == "Done") {
          donetasksTb.add(element);
        } else if (element['statusTask'] == "Archived") {
          archivedtasksTb.add(element);
        } else {
          newtasksTb.add(element);
        }
      });
      // ignore: avoid_print
      print(newtasksTb);
      emit(GetDataFromDBlState());
    });
  }

  void updateDataInDB({required int id, required String status}) async {
    database!.rawUpdate("UPDATE tasks SET statusTask = ? WHERE id = ?",
        [status, id]).then((value) {
      getDataFromDB(database);
      emit(UpdateDataInDBlState());
    });
  }

  void deleteDataInDB({required int id}) async {
    database!.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDB(database);
      emit(DeleteDataInDBlState());
    });
  }
}
