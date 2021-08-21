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
              padding: EdgeInsets.only(top: screenHeight*0.04, left: screenWidth*0.09),
            )
          ],
        ),
      ),
    );
  }
}