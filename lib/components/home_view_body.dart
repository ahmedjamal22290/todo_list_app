import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list_app/Widgets/custom_animated_bar.dart';
import 'package:todo_list_app/Widgets/selected_todo_item.dart';
import 'package:todo_list_app/Widgets/todo_item.dart';
import 'package:todo_list_app/constants.dart';
import 'package:todo_list_app/cubit/fetch_todo_cubit.dart';
import 'package:todo_list_app/cubit/fetch_todo_states.dart';
import 'package:todo_list_app/models/todo_model.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final List<String> categories = ["Complete", "Pending", "Overdue"];
  bool inSelectabledMood = false;

  int selectedIndex = 1;
  @override
  void initState() {
    super.initState();
    context.read<FetchTodoCubit>().fetchCompleteTodos();
    context.read<FetchTodoCubit>().fetchOverdueTodos();
    context.read<FetchTodoCubit>().fetchPendingTodos();
  }

  void updateCategory(int index) {
    setState(() {
      selectedIndex = index;
    });

    final cubit = context.read<FetchTodoCubit>();

    if (selectedIndex == 0) {
      cubit.fetchCompleteTodos();
    } else if (selectedIndex == 1) {
      cubit.fetchPendingTodos();
    } else {
      cubit.fetchOverdueTodos();
    }
  }

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
                  updateCategory(index);
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
          child: BlocBuilder<FetchTodoCubit, FetchTodoState>(
            builder: (context, state) {
              if (state is SuccessfulyFetchPendingState ||
                  state is SuccessfulyFetchCompleteState ||
                  state is SuccessfulyFetchOverDueState) {
                final list = (state as dynamic).list;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    if (!inSelectabledMood) {
                      return TodoItem(
                          onLongPress: () {
                            if (inSelectabledMood) {
                              inSelectabledMood = false;
                            } else {
                              inSelectabledMood = true;
                            }
                            setState(() {});
                          },
                          todo: list[index]);
                    } else {
                      bool selected = false;
                      return SelectedTodoItem(
                        onLongPress: () {
                          if (inSelectabledMood) {
                            inSelectabledMood = false;
                          } else {
                            inSelectabledMood = true;
                          }
                          setState(() {});
                        },
                        todo: list[index],
                        onTap: () {
                          if (selected) {
                            selected = false;
                          } else {
                            selected = true;
                          }
                          setState(() {});
                        },
                      );
                    }
                  },
                );
              } else {
                return const Center(
                  child: Text('No Items To Display'),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
