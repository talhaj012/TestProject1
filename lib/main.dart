import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Home Page/taskManager.dart';
import 'package:task_manager/Home%20Page/addTask.dart';
import 'package:task_manager/Home%20Page/todos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Task Manager';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Color(0xFFf6f5ee),
        ),
        home: AnimatedSplashScreen(
            duration: 1000,
            backgroundColor: Colors.white,
            // splashTransition: SplashTransition.slideTransition,
            splash: Lottie.asset('assets/splash_logo.json'),
            nextScreen: TaskManager(),),
        // home: AddTask(),
        // initialRoute: TaskManager.id,
      ),
    );
  }
}
