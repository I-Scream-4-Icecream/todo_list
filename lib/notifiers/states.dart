import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';

var _uuid = Uuid();

final _sampleTodos = [
  Todo('Buy cat food', 'Buy 3 dry food packages'),
  Todo('Learn Riverpod', 'Learn riverpod within 2 months')
];

final todosProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier(ref.read, _sampleTodos);
});

final completedProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todosProvider);
  return todos.where((todo) => todo.completed).toList();
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier(this.reader, [List<Todo>? state]): super(state ?? <Todo>[]);
  
  final Reader reader;

  void printList(ref) {
    final todos = ref.watch(todosProvider);
    for(final todo in todos) {
      print(todo.id);
      print(todo.title);
      print(todo.description);
      print(todo.completed);
    }
  }

  void add(String title, String description) {
    state = [...state, Todo(title, description)];
  }

  void toggle(String id) {
    if(reader(settingsProvider).state.deleteOnComplete) {
      remove(id);
      return;
    }
    
    state = state.map((todo) {
      if(todo.id == id) {
        return Todo(
          todo.title,
          todo.description,
          id: todo.id,
          completed: !todo.completed
        );
      }
      return todo;
    }).toList();
  }

  void edit({required String id, required String description, required String title}) {
    state = [
      for (final todo in state) 
        if (todo.id == id)
          Todo(
            title,
            description,
            id: todo.id,
            completed: todo.completed,
          )
        else
          todo,
    ];
  }

  void remove(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

@immutable
class Todo {
  final String id;
  final String title;
  final String description;
  final bool completed;

  Todo(
    this.title,
    this.description, {
    this.completed = false,
    String? id,
  }) : this.id = id ?? _uuid.v4();
}

final settingsProvider = StateProvider<Settings>((ref) {
  return Settings();
});

@immutable
class Settings {
  final bool deleteOnComplete;

  Settings({this.deleteOnComplete = false});
}