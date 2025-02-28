import 'package:flutter/material.dart';
import 'package:todo_list_app/components/home_view_body.dart';
import 'package:todo_list_app/constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = "HomeView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xff2A2A2A),
        elevation: 350,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 29,
        ),
      ),
      body: const HomeViewBody(),
    );
  }
}
