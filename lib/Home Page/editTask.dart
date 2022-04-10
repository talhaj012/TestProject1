import 'package:flutter/material.dart';
import 'package:task_manager/Home%20Page/taskManager.dart';
import 'package:provider/provider.dart';
import 'todoWidet.dart';
import 'todos.dart';
import 'todo.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String description = '';

  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState(){
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
  }

  EditTaskAction(){
    final isValid = _formKey.currentState?.validate();

    if(!isValid!){
      return;
    }
    else{
      final provider = Provider.of<TodosProvider>(context,listen: false);
      provider.updateTodoMethod(widget.todo, title, description);
      Navigator.of(context).pop();

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskManager(),
                ),
              );
            },
            child: Icon(Icons.arrow_back)),
        title: Text('Edit Tasks'),
        actions: [
          IconButton(
              onPressed: (){
                final provider = Provider.of<TodosProvider>(context,listen: false);
                provider.removeTodoMethod(widget.todo);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TaskManager()));
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'Enter Title:',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  autofocus: false,
                  controller: titleController,
                  onChanged: (title) {
                    setState(() {
                      this.title = title;
                    });
                  },
                  validator: (title) {
                    if (title!.isEmpty) {
                      return 'The title cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Enter Description:',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  autofocus: false,
                  controller: descController,
                  onChanged: (description) {
                    setState(() {
                      this.description = description;
                    });
                  },
                  validator: (title) {
                    if (title!.isEmpty) {
                      return 'The description cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        title = titleController.text;
                        description = descController.text;
                      });
                    }
                    EditTaskAction();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      shadowColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: Text(
                    'Edit',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
