import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';

var _uuid = Uuid();

final _sampleTodos = [
  Todo('Buy cat food'),
  Todo('Learn Riverpod')
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
      print(todo.completed);
      print(todo.description);
    }
  }

  void add(String description) {
    state = [...state, Todo(description)];
  }

  void toggle(String id) {
    if(reader(settingsProvider).state.deleteOnComplete) {
      remove(id);
      return;
    }
    
    state = state.map((todo) {
      if(todo.id == id) {
        return Todo(
          todo.description,
          id: todo.id,
          completed: !todo.completed
        );
      }
      return todo;
    }).toList();
  }

  void edit({required String id, required String description}) {
    state = [
      for (final todo in state) 
        if (todo.id == id)
          Todo(
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
  final String description;
  final bool completed;

  Todo(
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