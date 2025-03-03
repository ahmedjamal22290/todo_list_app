import 'package:flutter/material.dart';
import 'package:todo_list_app/components/edit_todo_body.dart';
import 'package:todo_list_app/models/todo_model.dart';

class EditTodoView extends StatelessWidget {
  const EditTodoView({super.key, required this.todo});
  static String id = "EditTodoView";
  final TodoModel todo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: EditTodoBody(
          todo: todo,
        ));
  }
}
