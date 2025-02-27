import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = "HomeView";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeViewBody(),
    );
  }
}

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
                    color: selectedIndex == index
                        ? const Color(0xff2A9D8F)
                        : const Color(0xff264653),
                  ),
                  child: Center(
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: selectedIndex == index
                            ? const Color(0xffE9C46A)
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
      ],
    );
  }
}
