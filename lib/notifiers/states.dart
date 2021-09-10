import 'package:riverpod/riverpod.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/database_services.dart';

List<Todo> todos = [];

final todosProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier(todos);
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier(List<Todo> state): super(state);
  
  void add(Todo todo) {
    state = [...state, todo];
    DatabaseServices().insertTodo(todo);
  }

  void toggle(int id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return Todo(
          todo.title,
          todo.description,
          completed: todo.completed == 1 ? 0:1,
        );
      }
      return todo;
    }).toList();
    DatabaseServices().updateTodo(state.firstWhere((todo) => todo.id == id));
  }

  void remove(int id) {
    DatabaseServices().deleteTodo(id);
    state = state.where((todo) => todo.id != id).toList();
  }

  void printList() {
    for(Todo todo in state) {
      print('Todo title: ' + todo.title);
    }
  }
}
/*import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';

final sharedPrefs = FutureProvider<SharedPreferences>(
  (_) async => await SharedPreferences.getInstance()
);

class TodoNotifier extends StateNotifier<List<Todo>> {
  final SharedPreferences? pref;

  TodoNotifier(this.pref): super(pref?.getStringList('todos') as List<Todo>);  

  static final provider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
    final pref = ref.watch(sharedPrefs).maybeWhen(
      data: (value) => value,
      orElse: () => null
    );
    return TodoNotifier(pref);
  });

  void saveItem(WidgetRef ref, Todo todo) {
    SharedPreferences? pref = ref.read(provider.notifier).pref;
    state = [...state, todo];
    print(state);
    List<String> jsonList = List.empty();
    for(var i in state) {
      jsonList.add(i.toJson());
    }
    pref!.setStringList('todos', jsonList);
    print(pref.getStringList('todos'));
  }

  void getData(String id) {
    if(state.contains(id)) {
      state = state.where((todo) => todo.id != id).toList();
    } else {
      state = [...state, ];
    }
    pref!.setStringList(key, state);
  }

  void printList(WidgetRef ref) {
    for(String todo in state) {
      print('Todo title: ' + todo);
    }
  }

}

@immutable
class Settings {
  final bool deleteOnComplete;

  Settings({this.deleteOnComplete = false});
}
final settingsProvider = StateProvider<Settings>((ref) {
  return Settings();
});*/