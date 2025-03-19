import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class NoteScreenController {
  static late Database database;
  static List<Map> notesList = [];
  static String? selectedCategory; // varible for selected category
  static const List<String> categories = [
    "Personal",
    "Professional",
    "Financial",
    "Educational",
  ];

  static Future<String> onDateSelection(BuildContext context) async {
    var selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    //print(selectedDate);

    // format date
    if (selectedDate != null) {
      String formatedDate = DateFormat("dd/MM/yyyy").format(selectedDate);
      print(formatedDate);
      return formatedDate;
    }

    return "";
  }

  static void onCategorySelection(String? value) {
    selectedCategory = value;
  }

  // static void addNote({
  //   required String title,
  //   required String des,
  //   required String date,
  // }) {
  //   Map note = {
  //     "title": title,
  //     "des": des,
  //     "date": date,
  //     "category": selectedCategory,
  //   };

  // notesList.add(note);
  // }

//sqflite codes

  static Future<void> initDb() async {
    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;
    }

    //open DB
    database = await openDatabase("note.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Note (id INTEGER PRIMARY KEY, title TEXT, des TEXT, date TEXT, category TEXT)');
    });
  }

// add data to DB
  static Future<void> addNote({
    required String title,
    required String des,
    required String date,
  }) async {
    await database.rawInsert(
        'INSERT INTO Note(title, des, date, category) VALUES(?, ?, ?,?)',
        [title, des, date, selectedCategory]);
    await getAllNotes();
    //
    //askabout await while calling addnote and on calling getallNotes
    //
  }

  // get data from DB

  static Future<void> getAllNotes() async {
    notesList = await database.rawQuery('SELECT * FROM Note');
    log(notesList.toString());
  }
}
