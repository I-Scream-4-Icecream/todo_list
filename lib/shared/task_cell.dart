import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/pages/home.dart';
import 'package:todo_list/notifiers/states.dart';
import 'package:todo_list/shared/decoration.dart';

class TaskCell extends StatelessWidget {
  TaskCell(
    this.screenHeight,
    this.screenWidth, {
    required this.id,
    this.description = "",
    required this.title,
    this.completed = false,
    required this.currentTodo
    }
  );

  final double screenHeight;
  final double screenWidth;
  final String id;
  final String title;
  final String description;
  final currentTodo;
  bool completed;

  @override
  Widget build(BuildContext context) {
    TextDecoration textDecoration = TextDecoration.none;

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
                    return Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.all(Color(0xffd103fc)),
                        shape: CircleBorder(),
                        value: todo.completed,
                        onChanged: (bool? value) {
                          ref.read(todosProvider.notifier).toggle(todo.id);
                          if(!todo.completed) {
                            textDecoration = TextDecoration.lineThrough;
                          }
                          ref.read(todosProvider.notifier).printList(ref);
                        },
                      ),
                    );
                  }
                ),
                SizedBox(width: 10.0),
                Consumer(
                  builder: (context, ref, child) {
                    final Todo todo = ref.watch(currentTodo);
                    if(todo.completed) {
                      textDecoration = TextDecoration.lineThrough;
                    } else {
                      textDecoration = TextDecoration.none;
                    }
                    return Text(
                      title,
                      style: TextStyle(
                        color: Color(0xFFbbc2d8),
                        fontSize: 18.0,
                        decoration: textDecoration
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        height: screenHeight*0.11,
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: taskDecoration(),
        constraints: BoxConstraints(
          minWidth: 160,
          maxWidth: 210,
        ),
      ),
    );
  }
}