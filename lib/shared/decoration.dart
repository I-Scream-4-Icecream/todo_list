import 'package:flutter/material.dart';

BoxDecoration taskDecoration() {
  return BoxDecoration(
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
  );
}
BoxDecoration buttonDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    color: Color(0xFF0a155a),
    boxShadow: [
      BoxShadow(
        color: Color(0xFF1c347b),
        spreadRadius: 0,
        blurRadius: 0,
        offset: Offset(0, 0), // changes position of shadow
      ),
    ],
  );
}
IconButton menuButton() {
  return IconButton(
    icon: Icon(Icons.notifications_outlined, color: Color(0xFFBBC2D8), size: 30.0),
    onPressed: () {}
  );
}