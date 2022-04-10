import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Home%20Page/todoWidet.dart';
import 'package:task_manager/Home%20Page/todos.dart';


class CompletedListWidget extends StatelessWidget {
  const CompletedListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todosCompleted;
    return todos.isEmpty
        ? Center(
            child: Text(
          'No Completed Tasks!!',
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
