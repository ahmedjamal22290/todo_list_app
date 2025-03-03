import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/Widgets/custom_button.dart';
import 'package:todo_list_app/Widgets/custom_descripition_field.dart';
import 'package:todo_list_app/Widgets/descripition_field_widget.dart';
import 'package:todo_list_app/Widgets/time_field_widget.dart';
import 'package:todo_list_app/Widgets/titile_field_widget.dart';
import 'package:todo_list_app/cubit/fetch_todo_cubit.dart';
import 'package:todo_list_app/models/todo_model.dart';

class EditTodoBody extends StatefulWidget {
  const EditTodoBody({
    super.key,
    required this.todo,
  });
  final TodoModel todo;

  @override
  State<EditTodoBody> createState() => _EditTodoBodyState();
}

class _EditTodoBodyState extends State<EditTodoBody> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _descripController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.text = widget.todo.title;
    _dateController.text = widget.todo.date.toString();
    _descripController.text = widget.todo.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleFieldWidget(
          controller: _controller,
          onChanged: (value) {
            _controller.text = value;
            widget.todo.title = value;
            setState(() {});
          },
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomDsecriptionFieldWidget(
            controller: _descripController,
            onChange: (value) {
              _descripController.text = value ?? widget.todo.description ?? "";
              widget.todo.description = value;
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
                  _dateController.text =
                      "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                  widget.todo.date = picked;
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
                  widget.todo.save();
                  if (widget.todo.status == 'C') {
                    BlocProvider.of<FetchTodoCubit>(context)
                        .fetchCompleteTodos();
                  } else if (widget.todo.status == 'P') {
                    BlocProvider.of<FetchTodoCubit>(context)
                        .fetchPendingTodos();
                  } else {
                    BlocProvider.of<FetchTodoCubit>(context)
                        .fetchOverdueTodos();
                  }
                  Navigator.pop(context);
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
    );
  }
}
