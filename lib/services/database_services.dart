import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/todo.dart';

class DatabaseServices {
  static List<Todo> todosList = List.empty();

  init() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo_list.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT, completed INTEGER)",
        );
      },
      version: 1,
    );
  } 
  Future<void> insertTodo(Todo todo) async {
    //final db = openDatabase(join(await getDatabasesPath(), 'todo_list.db'));
    final database = await init();
    database.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<Todo>> todos() async {
    //final db = openDatabase(join(await getDatabasesPath(), 'todo_list.db'));
    final database = await init();

    final List<Map<String, dynamic>> maps = await database.query('todos');

    return todosList = List.generate(maps.length, (index) {
      return Todo.id(
        maps[index]['title'],
        maps[index]['description'],
        id: maps[index]['id'],
        completed: maps[index]['completed']
      );
    }); 
  }

  Future<void> updateTodo(Todo todo) async {
    //final db = openDatabase(join(await getDatabasesPath(), 'todo_list.db'));
    final database = await init();

    await database.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id]
    );
  }

  Future<void> deleteTodo(int id) async {
    //final db = openDatabase(join(await getDatabasesPath(), 'todo_list.db'));
    final database = await init();

    await database.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}