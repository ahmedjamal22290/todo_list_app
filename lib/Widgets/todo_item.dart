import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list_app/constants.dart';
import 'package:todo_list_app/cubit/fetch_todo_cubit.dart';
import 'package:todo_list_app/models/todo_model.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.todo});
  final TodoModel todo;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
      decoration: BoxDecoration(
        color: const Color(0xff2A2A2A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.todo.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffE0E0E0),
                ),
              ),
              Text(
                'DeadLine: ${months[widget.todo.date.month]} ${widget.todo.date.day},${widget.todo.date.year}',
                style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    color: Color(0x7AE0E0E0),
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 1,
                      ),
                    ]),
              )
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                final cubit = BlocProvider.of<FetchTodoCubit>(context);

                setState(() {
                  if (widget.todo.status == 'P' || widget.todo.status == 'O') {
                    widget.todo.status = 'C';
                  } else {
                    widget.todo.status = 'P';
                  }
                  widget.todo.save();
                });

                if (widget.todo.status == 'C') {
                  cubit.fetchOverdueTodos();
                  cubit.fetchPendingTodos();
                } else if (widget.todo.status == 'P') {
                  cubit.fetchOverdueTodos();
                  cubit.fetchCompleteTodos();
                }
              },
              icon: Icon(
                widget.todo.status == 'P'
                    ? Icons.check_box_outline_blank_rounded
                    : widget.todo.status == 'C'
                        ? Icons.check_box
                        : Icons.indeterminate_check_box_outlined,
                size: 32,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
