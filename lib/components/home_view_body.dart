import 'package:flutter/material.dart';
import 'package:todo_list_app/constants.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final List<String> categories = ["Complete", "Pending", "Overdue"];
  final List<Widget> content = [
    const Center(child: Text("Complete", style: TextStyle(fontSize: 18))),
    const Center(child: Text("Pending", style: TextStyle(fontSize: 18))),
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
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 60,
                  width: MediaQuery.of(context).size.width / 3,
                  padding: const EdgeInsets.only(top: 5),
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    color: selectedIndex == index ? kFirstColor : kSecondColor,
                  ),
                  child: Center(
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: selectedIndex == index
                            ? kFontFirstColor
                            : Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
