import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Home%20Page/taskManager.dart';
import 'package:task_manager/Home%20Page/todo.dart';
import 'package:task_manager/Home%20Page/todos.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay(hour: 7, minute: 0);

  final titleController = TextEditingController();
  final descController = TextEditingController();


  AddTaskAction(){
    final isValid = _formKey.currentState?.validate();
    if(!isValid!){
      return;
    }else{
      final todo = Todo(
          id: DateTime.now().toString(),
          title: title,
          description:description,
          createdTime: DateTime.now()
      );

      final provider = Provider.of<TodosProvider>(context,listen: false);
      provider.addTodoMethod(todo);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TaskManager()));
    }
  }


  // getting the text date

  String getDateText(){
    if(date == null){
      return 'Select Date';
    }
    else{
      return DateFormat('dd/MM/yyyy').format(date);
      // return '${date.day}/${date.month}/${date.year}';
    }
  }


  // date picker
  Future pickDate(BuildContext context) async{
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: date ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate:  DateTime(DateTime.now().year + 5),
    );

    if(newDate == null){
      return;
    }
    setState(() {
      date = newDate;
    });
  }


  // time getter text

  String getTimeText(){
    if(time == null){
      return 'Select Time';
    }
    else{
      final hours = time.hour.toString().padLeft(2,'0');
      final minutes = time.minute.toString().padLeft(2,'0');

      return '$hours:$minutes';
    }

  }

  // Time picker

  Future pickTime(BuildContext context) async{
    final initialTime = TimeOfDay(hour: 7, minute: 0);
    final newTime = await showTimePicker(
        context: context,
        initialTime: time ?? initialTime,
    );

    if(newTime == null){
      return;
    }
    setState(() {
      time = newTime;
    });
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
        title: Text('Add Tasks'),
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
                  onChanged: (value) {
                    title = value;
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
                  onChanged: (value) {
                    description = value;
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
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  onTap: (){
                    pickDate(context);
                  },
                  tileColor: Colors.grey[200],
                  title: Text(getDateText()),
                  trailing: Icon(Icons.date_range_outlined),
                  iconColor: Colors.purple,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  onTap: (){
                    pickTime(context);
                  },
                  title: Text(getTimeText()),
                  trailing: Icon(Icons.access_time),
                  iconColor: Colors.purple,
                  tileColor: Colors.grey[200],
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
                    AddTaskAction();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      shadowColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: Text(
                    'Add',
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
