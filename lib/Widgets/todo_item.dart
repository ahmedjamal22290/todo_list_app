import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/constants.dart';
import 'package:todo_list_app/cubit/fetch_todo_cubit.dart';
import 'package:todo_list_app/models/todo_model.dart';
import 'package:todo_list_app/service/notifications_service.dart';
import 'package:todo_list_app/views/edit_todo_view.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.todo, required this.onLongPress});
  final TodoModel todo;
  final void Function()? onLongPress;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  Color getTodoColor(TodoModel todo) {
    if (todo.status == 'C') {
      return const Color(0xff43A047);
    } else if (todo.status == 'O') {
      return const Color(0xffE53935);
    } else if (todo.status == 'P') {
      bool flag = todo.date.difference(DateTime.now()).inDays <= 1;
      if (flag && widget.todo.isScheduled == false) {
        widget.todo.isScheduled = true;
        widget.todo.save();
        NotiService().scheduleNotification(
            title: 'Urgent Todo',
            body: widget.todo.title,
            hour: todo.date.hour,
            minute: widget.todo.date.minute);
        NotiService().showNotification(
          title: 'Urgent Todo',
          body: widget.todo.title,
        );
      }
      return flag ? const Color(0xFFCD7B00) : const Color(0xff2A2A2A);
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EditTodoView(todo: widget.todo);
        }));
      },
      onLongPress: widget.onLongPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
        decoration: BoxDecoration(
          color: getTodoColor(widget.todo),
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
                  style: TextStyle(
                    decoration: widget.todo.status == 'C'
                        ? TextDecoration.lineThrough
                        : null,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: widget.todo.status == 'C'
                        ? const Color(0xC3E0E0E0)
                        : const Color(0xffE0E0E0),
                  ),
                ),
                Text(
                  'DeadLine: ${months[widget.todo.date.month]} ${widget.todo.date.day},${widget.todo.date.year}',
                  style: TextStyle(
                    decoration: widget.todo.status == 'O'
                        ? TextDecoration.lineThrough
                        : null,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    color: const Color(0x9DE0E0E0),
                  ),
                )
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  final cubit = BlocProvider.of<FetchTodoCubit>(context);
                  final String char = widget.todo.status;
                  setState(() {
                    if (widget.todo.status == 'P') {
                      widget.todo.status = 'C';
                    } else if (widget.todo.status == 'O') {
                      widget.todo.status = 'C';
                    } else {
                      widget.todo.status = 'P';
                    }
                    widget.todo.save();
                  });
                  if (char == 'C') {
                    cubit.fetchPendingTodos();
                    cubit.fetchOverdueTodos();
                    cubit.fetchCompleteTodos();
                  } else if (char == 'P') {
                    cubit.fetchPendingTodos();
                  } else {
                    cubit.fetchOverdueTodos();
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
      ),
    );
  }
}
