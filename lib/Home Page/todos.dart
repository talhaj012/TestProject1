import 'package:flutter/material.dart';
import 'package:task_manager/Home Page/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [
    Todo(
        createdTime: DateTime.now(),
        title: 'Sample Task Title',
        description: 'Sample Task '
            'Description'),

  ];

  List<Todo> get todos {
    return
       _todos.where((todo) => todo.isDone == false).toList();
  }


  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void addTodoMethod(Todo todo){
    _todos.add(todo);

    notifyListeners();
  }

  void removeTodoMethod(Todo todo){
    _todos.remove(todo);
    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo){
    todo.isDone = !todo.isDone;
    notifyListeners();
    return todo.isDone;
  }

  void updateTodoMethod(Todo todo, String title, String description){
    todo.title = title;
    todo.description = description;
    notifyListeners();
  }

}
