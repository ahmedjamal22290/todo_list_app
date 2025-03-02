import 'package:flutter/material.dart';
import 'package:todo_list_app/Widgets/custom_floating_button.dart';
import 'package:todo_list_app/components/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = "HomeView";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButton: AddingFloatingButton(),
      body: HomeViewBody(),
    );
  }
}
