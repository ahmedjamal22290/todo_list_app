import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/Widgets/custom_floating_button.dart';
import 'package:todo_list_app/components/home_view_body.dart';
import 'package:todo_list_app/cubit/fetch_todo_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = "HomeView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchTodoCubit(),
      child: const Scaffold(
        floatingActionButton: AddingFloatingButton(),
        body: HomeViewBody(),
      ),
    );
  }
}
