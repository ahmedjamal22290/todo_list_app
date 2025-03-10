import 'package:flutter/material.dart';
import 'package:todo_list_app/constants.dart';

class DsecriptionFieldWidget extends StatelessWidget {
  const DsecriptionFieldWidget({super.key, required this.onSaved});
  final void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 5,
      onSaved: onSaved,
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
    );
  }
}
