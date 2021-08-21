import 'package:flutter/material.dart';
import 'package:todo_list/pages/add.dart';
import 'package:todo_list/pages/home.dart';

main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => Home(),
      '/add': (context) => AddTask(),
    },
  ));
}