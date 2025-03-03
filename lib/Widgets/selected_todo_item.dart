import 'package:flutter/material.dart';
import 'package:todo_list_app/constants.dart';
import 'package:todo_list_app/models/todo_model.dart';

class SelectedTodoItem extends StatefulWidget {
  const SelectedTodoItem(
      {super.key, required this.todo, required this.onTap, this.onLongPress});
  final TodoModel todo;
  final void Function()? onTap;
  final void Function()? onLongPress;
  @override
  State<SelectedTodoItem> createState() => _SelectedTodoItemState();
}

class _SelectedTodoItemState extends State<SelectedTodoItem> {
  bool selected = false;
  Color getTodoColor(TodoModel todo) {
    if (todo.status == 'C') {
      return const Color(0xff43A047);
    } else if (todo.status == 'O') {
      return const Color(0xffE53935);
    } else if (todo.status == 'P') {
      return todo.date.difference(DateTime.now()).inDays <= 1
          ? const Color(0xFFCD7B00)
          : const Color(0xff2A2A2A);
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: widget.onLongPress,
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
        decoration: BoxDecoration(
          border: Border.all(
            color: kHighlightColor,
            width: 2.2,
          ),
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
                  if (selected) {
                    selected = false;
                  } else {
                    selected = true;
                  }
                  setState(() {});
                },
                icon: Icon(
                  selected ? Icons.circle : Icons.circle_outlined,
                  size: 32,
                  color: kHighlightColor,
                ))
          ],
        ),
      ),
    );
  }
}
