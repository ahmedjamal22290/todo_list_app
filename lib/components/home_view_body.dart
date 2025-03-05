import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_list_app/Widgets/custom_animated_bar.dart';
import 'package:todo_list_app/Widgets/selected_todo_item.dart';
import 'package:todo_list_app/Widgets/todo_item.dart';
import 'package:todo_list_app/constants.dart';
import 'package:todo_list_app/cubit/fetch_todo_cubit.dart';
import 'package:todo_list_app/cubit/fetch_todo_states.dart';
import 'package:todo_list_app/models/todo_model.dart';
import 'package:todo_list_app/views/edit_todo_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final List<String> categories = ["Complete", "Pending", "Overdue"];
  final List<String> buttonsInSelectedMode = [
    'Edit',
    'Complete',
    'Delete',
  ];
  bool inSelectabledMode = false;
  List<bool> selected = [];

  List<TodoModel> selectedTodos = [];

  int selectedIndex = 1;
  @override
  void initState() {
    super.initState();
    selected = List.filled(Hive.box<TodoModel>(kBoxName).values.length, false);

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

  void deleteItems() {
    final box = Hive.box<TodoModel>(kBoxName);

    for (var todo in selectedTodos) {
      box.delete(todo.key);
    }
    selectedTodos.clear();

    setState(() {
      inSelectabledMode = false;
    });
  }

  void completeItems() {
    final box = Hive.box<TodoModel>(kBoxName);

    for (var todo in selectedTodos) {
      todo.status = 'C';
      box.put(todo.key, todo);
    }
    selectedTodos.clear();

    setState(() {
      inSelectabledMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: inSelectabledMode
              ? List.generate(buttonsInSelectedMode.length, (index) {
                  if ((index == 0 && selectedTodos.length > 1) ||
                      selectedIndex == 0 && index == 1) {
                    return Container();
                  } else {
                    return optionsMethod(index, context);
                  }
                })
              : List.generate(
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
                    if (!inSelectabledMode) {
                      return TodoItem(
                          onLongPress: () {
                            if (inSelectabledMode) {
                              inSelectabledMode = false;
                              selectedTodos.clear();
                            } else {
                              inSelectabledMode = true;
                            }
                            setState(() {});
                          },
                          todo: list[index]);
                    } else {
                      return selectingItemsMethod(list, index);
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

  SelectedTodoItem selectingItemsMethod(list, int index) {
    return SelectedTodoItem(
      onLongPress: () {
        if (inSelectabledMode) {
          inSelectabledMode = false;
        } else {
          inSelectabledMode = true;
        }
        setState(() {});
      },
      todo: list[index],
      onTap: () {
        if (selected[index]) {
          selected[index] = false;
          selectedTodos.remove(list[index]);
          log('remove todo ');
        } else {
          selectedTodos.add(list[index]);
          log('add todo ');
          selected[index] = true;
        }
        setState(() {});
      },
      selected: selected[index],
    );
  }

  GestureDetector optionsMethod(int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (index == 2) {
          deleteItems();
          inSelectabledMode = false;
          BlocProvider.of<FetchTodoCubit>(context).fetchPendingTodos();
          setState(() {});
        } else if (index == 1) {
          completeItems();
          inSelectabledMode = false;
          BlocProvider.of<FetchTodoCubit>(context).fetchCompleteTodos();
          BlocProvider.of<FetchTodoCubit>(context).fetchPendingTodos();
          setState(() {});
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditTodoView(todo: selectedTodos.first);
          }));
        }
      },
      child: Container(
        height: 60,
        width: selectedIndex == 0
            ? (selectedTodos.length > 1
                ? MediaQuery.of(context).size.width / 1
                : MediaQuery.of(context).size.width / 2)
            : (selectedTodos.length > 1
                ? MediaQuery.of(context).size.width / 2
                : MediaQuery.of(context).size.width / 3),
        padding: const EdgeInsets.only(top: 5),
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            border: const Border.symmetric(
                vertical: BorderSide(color: Colors.white, width: 0.9)),
            color: kHighlightColor),
        child: Center(
            child: Text(
          buttonsInSelectedMode[index],
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
