import 'package:flutter/material.dart';
import 'package:todo_list_app/constants.dart';

class CutsomAnimatedBar extends StatelessWidget {
  const CutsomAnimatedBar(
      {super.key,
      required this.selectedIndex,
      required this.categories,
      required this.index});

  final int selectedIndex, index;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 60,
      width: MediaQuery.of(context).size.width / 3,
      padding: const EdgeInsets.only(top: 5),
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: selectedIndex == index ? kHighlightColor : kSecondColor,
      ),
      child: Center(
        child: Text(
          categories[index],
          style: TextStyle(
            color: selectedIndex == index ? kFontFirstColor : Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
