import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:todo_list/pages/home.dart';

main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home()
  ));
}