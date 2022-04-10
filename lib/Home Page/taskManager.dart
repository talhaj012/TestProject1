import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/Home Page/addTask.dart';
import 'package:task_manager/Home Page/taskWidget.dart';
import 'package:task_manager/Home Page/completedListWidget.dart';


class TaskManager extends StatefulWidget {

  const TaskManager({Key? key}) : super(key: key);

  static String id = 'TaskManager';

  @override
  _TaskManagerState createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  int selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final tabs = [TaskListWidget(), CompletedListWidget()];

    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: selectedIndex,
        showElevation: true,
        backgroundColor: Theme.of(context).primaryColor,
        // unselectedItemColor: Colors.white.withOpacity(0.7),
        // selectedItemColor: Colors.white,
        // currentIndex: selectedIndex,
        // onTap: (index) {
        //   setState(() {
        //     selectedIndex = index;
        //   });
        // },

        onItemSelected: (index) => setState(() {
          selectedIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        }),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              activeColor: Colors.white,
              icon: Icon(Icons.fact_check_outlined),
              title: Text('Tasks')),
          // BottomNavyBarItem(
          //   activeColor: Colors.white,
          // icon: Icon(Icons.done),
          //     icon:
          //     title: Text('sjfbcj')),
          BottomNavyBarItem(activeColor: Colors.white,icon: Icon(Icons.done), title: Text('Archived')),
        ],
      ),

      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => selectedIndex = index);
          },
          children: [tabs[selectedIndex]],
        ),
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(),
            ),
          );
        },
        backgroundColor: Colors.white,
         foregroundColor: Colors.purple,
        icon: Icon(
          Icons.add,
        ),
         label: Text('Add Task',
         style: TextStyle(
           fontWeight: FontWeight.bold
         ),
         ),
      ),
      // body: tabs[selectedIndex],
    );
  }
}
