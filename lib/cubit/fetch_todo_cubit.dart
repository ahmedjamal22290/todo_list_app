import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_list_app/constants.dart';
import 'package:todo_list_app/cubit/fetch_todo_states.dart';
import 'package:todo_list_app/models/todo_model.dart';

class FetchTodoCubit extends Cubit<FetchTodoState> {
  FetchTodoCubit() : super(FetchTodoInitial());
  fetchPendingTodos() {
    var todosBox = Hive.box<TodoModel>(kBoxName).values.toList();
    List<TodoModel> pendingTodos = [];
    for (int i = 0; i < todosBox.length; i++) {
      if (todosBox[i].status == 'P') {
        pendingTodos.add(todosBox[i]);
      }
    }
    if (pendingTodos.isEmpty) {
      emit(EmptyListState());
    } else {
      emit(SuccessfulyFetchState(list: pendingTodos));
    }
  }
}
