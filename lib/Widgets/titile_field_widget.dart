import 'package:flutter/material.dart';
import 'package:todo_list_app/constants.dart';

class TitleFieldWidget extends StatelessWidget {
  const TitleFieldWidget({super.key, required this.controller, this.onChanged});
  final TextEditingController controller;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This Field is required";
        }
        return null;
      },
      style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 9),
        hintText: "Title",
        hintStyle: const TextStyle(fontSize: 23, color: Color(0xffE0E0E0)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: kHighlightColor,
        )),
      ),
    );
  }
}
