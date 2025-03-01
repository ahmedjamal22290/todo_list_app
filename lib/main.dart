import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list_app/constants.dart';
import 'package:todo_list_app/models/todo_model.dart';
import 'package:todo_list_app/views/add_todo_view.dart';
import 'package:todo_list_app/views/home_view.dart';

void main() async {
  Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  Hive.openBox<TodoModel>(kBoxName);
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: {
        HomeView.id: (context) => const HomeView(),
        AddTodoView.id: (context) => const AddTodoView(),
      },
      initialRoute: HomeView.id,
    );
  }
}
