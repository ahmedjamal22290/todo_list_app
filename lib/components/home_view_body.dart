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
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 60,
                  width: MediaQuery.of(context).size.width / 3,
                  padding: const EdgeInsets.only(top: 5),
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    color:
                        selectedIndex == index ? kHighlightColor : kSecondColor,
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

class TodoItem extends StatelessWidget {
  const TodoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
      decoration: BoxDecoration(
        color: const Color(0xff2A2A2A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffE0E0E0),
                ),
              ),
              Text(
                'DeadLine: July 25,2021',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    color: Color(0x7AE0E0E0),
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 1,
                      ),
                    ]),
              )
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.check_box_outline_blank_rounded,
                size: 32,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
