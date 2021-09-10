import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/pages/add.dart';
import 'package:todo_list/pages/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/services/database_services.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseServices databaseServices = DatabaseServices();
  await databaseServices.init();
  
  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Home(),
        '/add': (context) => AddTodo(),
      },
    )
  ));
}