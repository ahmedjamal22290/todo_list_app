import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo_list_app/Widgets/descripition_field_widget.dart';
import 'package:todo_list_app/Widgets/time_field_widget.dart';
import 'package:todo_list_app/Widgets/titile_field_widget.dart';
import 'package:todo_list_app/constants.dart';

class AddTodoBody extends StatefulWidget {
  const AddTodoBody({
    super.key,
  });

  @override
  State<AddTodoBody> createState() => _AddTodoBodyState();
}

class _AddTodoBodyState extends State<AddTodoBody> {
  final TextEditingController _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleFieldWidget(),
        const SizedBox(height: 30),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: DsecriptionFieldWidget(),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TimeFieldWidget(
            controller: _dateController,
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(2035),
              );
              if (picked != null) {
                setState(() {
                  _dateController.text =
                      "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                });
              }
            },
          ),
        ),
        const SizedBox(height: 40),
        const CustomButton(
          icon: Icon(
            Icons.cancel_outlined,
            color: Colors.red,
          ),
          text: 'Cancel',
        )
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });
  final Icon icon;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height / 19,
        width: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: const Border(
            top: BorderSide(color: Colors.grey),
            bottom: BorderSide(color: Colors.grey),
            right: BorderSide(color: Colors.grey),
            left: BorderSide(color: Colors.grey),
          ),
          color: kSecondColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
