import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo_list_app/Widgets/custom_button.dart';
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
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  @override
  GlobalKey<FormState> formKey = GlobalKey();
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TitleFieldWidget(
            controller: _controller,
            onChanged: (value) {
              _controller.text = value;
            },
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DsecriptionFieldWidget(
              onSaved: (value) {},
            ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                  ),
                  text: 'Cancel',
                ),
                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      log('Success');
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  text: 'Save',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
