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
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xFF3d47af),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Padding(
              padding: EdgeInsets.only(left: screenWidth*0.04, right: screenWidth*0.04, top: screenHeight*0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: Color(0xFFBBC2D8), size: 30.0),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  ),
                  menuButton()
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
            textfield(screenHeight, screenWidth, titleController, label: 'Title'),
            textfield(screenHeight, screenWidth, descriptionController, label: 'Description', lines: 4, length: 550, topPadding: 0.01),
            Consumer(
              builder: (context, ref, child) {
                return Center(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      onTap: () {
                        if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                          ref.read(todosProvider.notifier).add(titleController.text, descriptionController.text);
                          titleController.clear();
                          descriptionController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'You task is added successfully.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100
                                )
                              ),
                              backgroundColor: Color(0xFF0a155a),
                            )
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'You have to enter data in all the fields.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300
                                )
                              ),
                              backgroundColor: Color(0xFF0a155a),
                            )
                          );
                        }
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

  Padding textfield(double screenHeight, double screenWidth, TextEditingController textController, {int length = 30, int lines = 1, String label = '', double topPadding = 0.06}) {
    return Padding(
            padding: EdgeInsets.only(top: screenHeight*topPadding, left: screenWidth*0.09, right: screenWidth*0.09),
            child: TextField(
              controller: textController,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white),
              cursorWidth: 1,
              maxLines: lines,
              maxLength: length,
              cursorColor: Color(0xFFBBC2D8),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(color: Color(0xFFBBC2D8), fontWeight: FontWeight.w100),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide(color: Color(0xFFBBC2D8))
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide(color: Color(0xFFBBC2D8)),
                ),
                counterStyle: TextStyle(color: Color(0xFFBBC2D8)),
              ),
            ),
          );
  }
}