import 'package:flutter/material.dart';

class TaskCell extends StatelessWidget {
  const TaskCell({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight*0.03, right: screenWidth*0.05, left: screenWidth*0.02),
      child: Container(
        height: screenHeight*0.11,
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xFF0a155a),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF1c347b),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(-2, 4), // changes position of shadow
            ),
          ],
        ),
        constraints: BoxConstraints(
          minWidth: 160,
          maxWidth: 210,
        ),
      ),
    );
  }
}