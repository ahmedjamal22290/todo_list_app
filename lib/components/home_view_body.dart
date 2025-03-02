import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list_app/Widgets/custom_animated_bar.dart';
import 'package:todo_list_app/Widgets/todo_item.dart';
import 'package:todo_list_app/constants.dart';
import 'package:todo_list_app/models/todo_model.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final List<String> categories = ["Complete", "Pending", "Overdue"];
  final List<Widget> content = [
    const Center(child: Text("Complete", style: TextStyle(fontSize: 18))),
    TodoItem(
      todo: Hive.box<TodoModel>(kBoxName).values.first,
    ),
    const Center(child: Text("Overdue", style: TextStyle(fontSize: 18))),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(
            categories.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  selectedIndex = index;
                  setState(() {});
                },
                child: CutsomAnimatedBar(
                  index: index,
                  selectedIndex: selectedIndex,
                  categories: categories,
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView(
            children: [content[selectedIndex]],
          ),
        )
      ],
    );
  }
}
