import 'package:flutter/material.dart';
import 'package:todo_list_app/service/notifications_service.dart';
import 'package:todo_list_app/views/add_todo_view.dart';

class AddingFloatingButton extends StatelessWidget {
  const AddingFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        NotiService notiService = NotiService();
        await notiService.initNotification();
        notiService.showNotification(
          title: "Test",
          body: "Test Body",
        );
        Navigator.pushNamed(context, AddTodoView.id);
      },
      backgroundColor: const Color(0xff2A2A2A),
      elevation: 350,
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 29,
      ),
    );
  }
}
