import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/notifiers/states.dart';
import 'package:todo_list/shared/decoration.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final textController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xFF3d47af),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Padding(
              padding: EdgeInsets.only(left: screenWidth*0.04, right: screenWidth*0.04, top: screenHeight*0.06),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: Color(0xFFBBC2D8), size: 30.0),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  ) 
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth*0.09, top: screenHeight*0.06),
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
                controller: textController,
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
            Consumer(
              builder: (context, ref, child) {
                return Center(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      onTap: () {
                        ref.read(todosProvider.notifier).add(textController.text);
                        ref.read(todosProvider.notifier).printList(ref);
                      },
                      child: Ink(
                        decoration: buttonDecoration(),
                        height: 50.0,
                        width: 150,
                        child: Center(
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Color(0xFFbbc2d8),
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300
                            )
                          )
                        ),
                      )
                    )
                  ),
                );
              }, 
            )
          ],
        ),
      ),
    );
  }
}