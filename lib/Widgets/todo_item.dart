import 'package:flutter/material.dart';

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
