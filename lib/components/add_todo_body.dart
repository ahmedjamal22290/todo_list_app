import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_list_app/Widgets/custom_button.dart';
import 'package:todo_list_app/Widgets/descripition_field_widget.dart';
import 'package:todo_list_app/Widgets/time_field_widget.dart';
import 'package:todo_list_app/Widgets/titile_field_widget.dart';
import 'package:todo_list_app/constants.dart';
import 'package:todo_list_app/cubit/fetch_todo_cubit.dart';
import 'package:todo_list_app/models/todo_model.dart';

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
  GlobalKey<FormState> formKey = GlobalKey();
  TodoModel todo = TodoModel(title: '', date: DateTime.now(), status: 'P');
  late double height = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Stack(
        children: [
          AnimatedContainer(
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 600),
            height: height,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(80),
                  bottomLeft: Radius.circular(80)),
              color: kSecondColor,
            ),
          ),
          Column(
            children: [
              TitleFieldWidget(
                controller: _controller,
                onChanged: (value) {
                  _controller.text = value;
                  todo.title = value;
                  setState(() {
                    height = MediaQuery.of(context).size.height * 0.49;
                  });
                },
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DsecriptionFieldWidget(
                  onSaved: (value) {
                    todo.description = value;
                    setState(() {});
                  },
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
                        height = MediaQuery.of(context).size.height * 0.49;

                        _dateController.text =
                            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                        todo.date = picked;
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
                          formKey.currentState!.save();
                          Hive.box<TodoModel>(kBoxName).add(todo);
                          BlocProvider.of<FetchTodoCubit>(context)
                              .fetchPendingTodos();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: kSecondColor,
                              content: const Text(
                                'Added Succefly',
                                style: TextStyle(color: Colors.white),
                              )));
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
