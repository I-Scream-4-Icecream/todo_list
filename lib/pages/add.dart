import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  const AddTask({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF3d47af),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Padding(
              padding: EdgeInsets.only(top: screenHeight*0.18, left: screenWidth*0.09),
              child: Text(
                'Add Task',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight*0.06, left: screenWidth*0.09, right: screenWidth*0.09),
              child: TextField(
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white),
                cursorWidth: 1,
                maxLength: 16,
                cursorColor: Color(0xFFBBC2D8),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    borderSide: BorderSide(color: Color(0xFFBBC2D8))
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(color: Color(0xFFBBC2D8))
                  ),
                  hintText: 'Task Title',
                  hintStyle: TextStyle(color: Color(0xFFBBC2D8), fontWeight: FontWeight.w100),
                  counterStyle: TextStyle(color: Color(0xFFBBC2D8))
                ),
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  print(0);
                },
                child: Material(
                  child: Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  /*height: screenHeight*0.11,
                  padding: EdgeInsets.only(left: 20, right: 20),*/
                  /*decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xFFd103fc),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFd103fc).withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(-2, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  width: 210*/
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}