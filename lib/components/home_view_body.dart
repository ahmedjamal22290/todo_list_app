import 'package:flutter/material.dart';
import 'package:todo_list_app/Widgets/custom_animated_bar.dart';
import 'package:todo_list_app/Widgets/todo_item.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final List<String> categories = ["Complete", "Pending", "Overdue"];
  final List<Widget> content = [
    const Center(child: Text("Complete", style: TextStyle(fontSize: 18))),
    const Center(child: TodoItem()),
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
