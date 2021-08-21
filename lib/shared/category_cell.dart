import 'package:flutter/material.dart';

class CategoryCell extends StatelessWidget {
  const CategoryCell({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight*0.03, bottom: screenHeight*0.03, right: screenWidth*0.03),
      child: Container(
        height: screenHeight*0.40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
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