import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:todo_list/shared/category_cell.dart';

class Home extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                  IconButton(
                    icon: Icon(Icons.notifications_outlined, color: Color(0xFFBBC2D8), size: 30.0),
                    onPressed: () {}
                  )
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
                  //color: Color()
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight*0.04, left: screenWidth*0.09),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 18.0, color: Color(0xFFBBC2D8)),
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
                    SizedBox(width: screenWidth*0.06)
                  ],
                ),
              ),
            )
          ]
        )
      )

    );
  }
}

