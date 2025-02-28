import 'package:flutter/material.dart';
import 'package:todo_list_app/views/add_todo_view.dart';
import 'package:todo_list_app/views/home_view.dart';

void main() {
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
