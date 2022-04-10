import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Home Page/todo.dart';
import 'package:task_manager/Home Page/todos.dart';
import 'package:task_manager/Home Page/todoWidet.dart';

class TaskListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;
    return todos.isEmpty
        ? Center(
            child: Text(
              '0 Task Added',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoWidget(todo: todo);
            },
            separatorBuilder: (context, index) => Container(
                  height: 8,
                ),
            itemCount: todos.length);
  }
}
