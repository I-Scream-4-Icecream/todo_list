import 'package:flutter/material.dart';
import 'package:todo_list/pages/add.dart';
import 'package:todo_list/pages/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

main() async {
  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Home(),
        '/add': (context) => AddTask(),
      },
    )
  ));
}