import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list_app/constants.dart';
import 'package:todo_list_app/cubit/fetch_todo_cubit.dart';
import 'package:todo_list_app/models/todo_model.dart';
import 'package:todo_list_app/service/notifications_service.dart';
import 'package:todo_list_app/views/add_todo_view.dart';
import 'package:todo_list_app/views/home_view.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>(kBoxName);
  await requestPermissions();
  await NotiService().initNotification();
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchTodoCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        routes: {
          HomeView.id: (context) => const HomeView(),
          AddTodoView.id: (context) => const AddTodoView(),
        },
        initialRoute: HomeView.id,
      ),
    );
  }
}
