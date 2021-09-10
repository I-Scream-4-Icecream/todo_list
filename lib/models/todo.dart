import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';


var _uuid = Uuid();

@immutable
class Todo {
  static int numOfTodos = 0;
  late int id;
  final String title;
  final String description;
  final int completed;

  Todo(this.title, this.description, {this.completed = 0}) {
    this.id = numOfTodos;
    numOfTodos++;
  }

  Todo.id(this.title, this.description, {this.completed = 0, this.id = 0}) {
    this.id = numOfTodos;
    numOfTodos++;
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      json['title'] as String,
      json['description'] as String,
      completed: json['completed'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed
    };
  }

  @override  
  String toString() {
    return '{id:$id, title:${this.title}, description:${this.description}, completed:${this.completed}';
  }
}

