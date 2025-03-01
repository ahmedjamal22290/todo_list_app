import 'package:flutter/material.dart';
import 'package:todo_list_app/components/add_todo_body.dart';

class AddTodoView extends StatelessWidget {
  const AddTodoView({super.key});
  static String id = "AddView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const AddTodoBody(),
    );
  }
}
