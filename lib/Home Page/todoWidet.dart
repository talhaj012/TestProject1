import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Home Page/todo.dart';
import 'package:task_manager/Home%20Page/todos.dart';
import 'package:task_manager/Home%20Page/utils.dart';

import 'editTask.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({required this.todo, Key? key}) : super(key: key);

  deleteTodoAction(BuildContext context, Todo todo){
    final provider = Provider.of<TodosProvider>(context,listen: false);
    provider.removeTodoMethod(todo);
    Utils.showSnackBar(context,'Task Deleted!!');
  }

  editTodoAction(BuildContext context,Todo todo){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditTodoPage(todo:todo)));
  }


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => editTodoAction(context,todo),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed:(context)=> deleteTodoAction(context,todo),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        key: Key(todo.id),
        child: buildTodo(context),
      ),
    );
  }

  Widget buildTodo(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Checkbox(
            value: todo.isDone,
            activeColor: Theme.of(context).primaryColor,
            checkColor: Colors.white,
            onChanged: (value) {
              final provider = Provider.of<TodosProvider>(context,listen: false);

              final isDone = provider.toggleTodoStatus(todo);
              Utils.showSnackBar(context,
                isDone ? 'Task Completed' : 'Task Marked incomplete'
              );
            },
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 22),
                ),
                if (todo.description.isNotEmpty)
                  Container(
                    child: Text(
                      todo.description,
                      style: TextStyle(fontSize: 20, height: 1.5),
                    ),
                  ),
                SizedBox(
                  height:20
                ),
                Container(
                  child: Row(
                    children: [
                      Text('Swipe Right to Edit/',
                        style: TextStyle(
                          color: Colors.green,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text('Swipe Left to Delete/',
                          style: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic
                      ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
