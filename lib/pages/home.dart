import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/notifiers/states.dart';
import 'package:todo_list/services/database_services.dart';
import 'dart:developer';

import 'package:todo_list/shared/category_cell.dart';
import 'package:todo_list/shared/decoration.dart';
import 'package:todo_list/shared/task_cell.dart';

class Home extends ConsumerStatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final DatabaseServices databaseServices = DatabaseServices();
  final _currentTodo = Provider<Todo>((ref) => throw UnimplementedError());
  static bool didBuild = false;

  get getCurrentTodo => _currentTodo;

  @override
  void initState() {
    super.initState();
    if(!didBuild) {
      databaseServices.todos().then(
        (value) {
          ref.watch(todosProvider).addAll(value);
          setState(() {
            didBuild = true;
          });
        }
      );
    }
  }

  void _showMenu(Offset offset, context) async {
    double left = offset.dx;
    double top = offset.dy;

    var selected = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem(
          child: Text(
            'Settings',
            style: TextStyle(color: Colors.grey[600])
          ),
          value: 'settings',
          height: 45.0,
        ),
        PopupMenuItem(
          child: Text(
            'Logout',
            style: TextStyle(color: Colors.grey[600])
          ),
          value: 'logout',
          height: 45.0
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF3D47AF),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Color(0xFFd103fc),
        child: Container(
          child: Icon(Icons.add_sharp, color: Colors.white),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFd103fc).withOpacity(0.3),
                spreadRadius: 4,
                blurRadius: 3,
                offset: Offset(3, 5)
              )
            ]
          ),
        )
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFF2643C4),
          child: Column(
            children: <Widget> [
              Container(
                width: double.infinity,
                child: DrawerHeader(
                  child: Container() //When Auth is ready add the user's name to the header and the user's year
                )
              )
            ]
          ),
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Padding(
              padding: EdgeInsets.only(left: screenWidth*0.04, right: screenWidth*0.04, top: screenHeight*0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  IconButton(
                    icon: Icon(Icons.menu, color: Color(0xFFBBC2D8), size: 30.0),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                      print(_scaffoldKey.currentState.toString());
                    },
                  ),
                  menuButton()
                ]
              ),  
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth*0.09, top: screenHeight*0.06),
              child: Text(
                'What\'s up, Remi!',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.white
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight*0.04, left: screenWidth*0.09),
              child: Text(
                'CATEGORIES',
                style: TextStyle(fontSize: 14.0, color: Color(0xFFBBC2D8)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: SizedBox(
                height: screenHeight*0.25,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: <Widget> [
                    SizedBox(width: screenWidth*0.09),
                    CategoryCell(screenHeight: screenHeight, screenWidth: screenWidth),
                    CategoryCell(screenHeight: screenHeight, screenWidth: screenWidth),
                    CategoryCell(screenHeight: screenHeight, screenWidth: screenWidth),
                    CategoryCell(screenHeight: screenHeight, screenWidth: screenWidth),
                    SizedBox(width: screenWidth*0.06)
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight*0.01, left: screenWidth*0.09, bottom: screenHeight*0.03),
              child: Text(
                'TODAY\'S TASKS ',
                style: TextStyle(fontSize: 14.0, color: Color(0xFFBBC2D8)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: screenWidth*0.04, left: screenWidth*0.07),
              child: SizedBox(
                height: screenHeight*0.5,
                child: Consumer(
                  builder: (context, ref, child) {
                    return ListView(
                      shrinkWrap: false,
                      children: <Widget> [
                        ...ref.watch(todosProvider).map(
                          (todo) => ProviderScope(
                            child: TaskCell(screenHeight, screenWidth, id: todo.id, title: todo.title, description: todo.description, currentTodo: _currentTodo),
                            //child: TaskCell(screenHeight, screenWidth, id: '0', title: todo, description: 'none', currentTodo: _currentTodo),
                            overrides: [
                              _currentTodo.overrideWithValue(todo)
                            ],
                          )
                        ).toList()
                      ],
                    );
                  }
                )
              ),
            ),
          ]
        )
      )
    );
  }
}