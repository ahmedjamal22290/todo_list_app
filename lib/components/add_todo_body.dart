import 'package:flutter/material.dart';
import 'package:todo_list_app/Widgets/descripition_field_widget.dart';
import 'package:todo_list_app/Widgets/titile_field_widget.dart';

class AddTodoBody extends StatelessWidget {
  const AddTodoBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TitleFieldWidget(),
        SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: DsecriptionFieldWidget(),
        ),
      ],
    );
  }
}
