import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/pages/home.dart';
import 'package:todo_list/notifiers/states.dart';

class TaskCell extends StatelessWidget {
  TaskCell(
    this.screenHeight,
    this.screenWidth, {
    required this.id,
    this.description = "",
    this.completed = false,
    required this.currentTodo
    }
  );

  final double screenHeight;
  final double screenWidth;
  final String id;
  final String description;
  final currentTodo;
  bool completed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight*0.03, right: screenWidth*0.05, left: screenWidth*0.02),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final Todo todo = ref.watch(currentTodo);
                    return Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.all(Color(0xffd103fc)),
                      shape: CircleBorder(),
                      value: todo.completed,
                      onChanged: (bool? value) {
                        ref.read(todosProvider.notifier).toggle(todo.id);
                        ref.read(todosProvider.notifier).printList(ref);
                      },
                    );
                  }
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Color(0xFFbbc2d8),
                    fontSize: 18.0
                  ),
                ),
              ],
            ),
          ],
        ),
        height: screenHeight*0.11,
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: boxDecoration(),
        constraints: BoxConstraints(
          minWidth: 160,
          maxWidth: 210,
        ),
      ),
    );
  }

  BoxDecoration boxDecoration() {
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
}