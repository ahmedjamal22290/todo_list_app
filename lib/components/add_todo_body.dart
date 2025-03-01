import 'package:flutter/material.dart';
import 'package:todo_list_app/Widgets/descripition_field_widget.dart';
import 'package:todo_list_app/Widgets/titile_field_widget.dart';
import 'package:todo_list_app/constants.dart';

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
        SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: TimeFieldWidget(),
        )
      ],
    );
  }
}

class TimeFieldWidget extends StatelessWidget {
  const TimeFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Select Date',
        suffixIcon: const Icon(Icons.calendar_today_rounded),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kHighlightColor),
        ),
      ),
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
      },
    );
  }
}
