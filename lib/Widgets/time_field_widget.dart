import 'package:flutter/material.dart';
import 'package:todo_list_app/constants.dart';

class TimeFieldWidget extends StatefulWidget {
  const TimeFieldWidget({
    super.key,
    required this.controller,
    this.onTap,
  });
  final TextEditingController controller;
  final void Function()? onTap;

  @override
  State<TimeFieldWidget> createState() => _TimeFieldWidgetState();
}

class _TimeFieldWidgetState extends State<TimeFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: widget.controller,
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
      onTap: widget.onTap,
    );
  }
}
