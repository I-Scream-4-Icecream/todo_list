import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Column(
          children: <Widget> [
            Container(
              width: double.infinity,
              color: Color(0x2643C4),
              child: DrawerHeader(
                child: Container() //When Auth is ready add the user's name to the header and the user's year
              )
            )
          ]
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Padding(
              padding: EdgeInsets.only(left: screenWidth*0.04, right: screenWidth*0.04, top: screenHeight*0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.grey[600], size: 30.0),
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                      print(scaffoldKey.currentState.toString());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications_outlined, color: Colors.grey[600], size: 30.0),
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
            )
          ]
        )
      )

    );
  }
}