import 'package:flutter/material.dart';
import 'package:todo_list_app/Widgets/titile_field_widget.dart';
import 'package:todo_list_app/constants.dart';

class AddTodoView extends StatelessWidget {
  const AddTodoView({super.key});
  static String id = "AddView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const TitleFieldWidget(),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                label: const Text(
                  'Description ',
                  style: TextStyle(color: Color(0xffE0E0E0)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: kHighlightColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
