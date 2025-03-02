import 'package:bloc/bloc.dart';
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
    List<TodoModel> overdueTodos =
        todosBox.where((todo) => todo.status == 'O').toList();

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
