import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_list_app/constants.dart';
import 'package:todo_list_app/cubit/fetch_todo_states.dart';
import 'package:todo_list_app/models/todo_model.dart';

class FetchTodoCubit extends Cubit<FetchTodoState> {
  FetchTodoCubit() : super(FetchTodoInitial());

  fetchPendingTodos() {
    var todosBox = Hive.box<TodoModel>(kBoxName).values.toList();
    List<TodoModel> pendingTodos =
        todosBox.where((todo) => todo.status == 'P').toList();

    if (pendingTodos.isEmpty) {
      emit(EmptyPendingListState());
    } else {
      emit(SuccessfulyFetchPendingState(list: pendingTodos));
    }
  }

  fetchOverdueTodos() {
    var todosBox = Hive.box<TodoModel>(kBoxName).values.toList();
    List<TodoModel> overdueTodos = [];
    for (int i = 0; i < todosBox.length; i++) {
      if (todosBox[i].date.isBefore(DateTime.now()) &&
          todosBox[i].status != 'C') {
        overdueTodos.add(todosBox[i]);
        todosBox[i].status = 'O';
      }
    }
    if (overdueTodos.isEmpty) {
      emit(EmptyOverdueListState());
    } else {
      emit(SuccessfulyFetchOverDueState(list: overdueTodos));
    }
  }

  fetchCompleteTodos() {
    var todosBox = Hive.box<TodoModel>(kBoxName).values.toList();
    List<TodoModel> completeTodos =
        todosBox.where((todo) => todo.status == 'C').toList();

    if (completeTodos.isEmpty) {
      emit(EmptyCompleteListState());
    } else {
      emit(SuccessfulyFetchCompleteState(list: completeTodos));
    }
  }
}
