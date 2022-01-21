import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_learning_u1/home_screen.dart';
import 'package:hive_learning_u1/todo.dart';
import 'package:path_provider/path_provider.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory =await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  //register adapter
  Hive.registerAdapter(TodoAdapter());
  //open a new box with todo data
  await Hive.openBox<Todo>('todo');

  await Hive.openBox('user');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(),
    );
  }
}
