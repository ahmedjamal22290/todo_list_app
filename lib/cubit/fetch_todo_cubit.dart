import 'package:bloc/bloc.dart';
import 'package:todo_list_app/cubit/fetch_todo_states.dart';

class FetchTodoCubit extends Cubit<FetchTodoState> {
  FetchTodoCubit() : super(FetchTodoInitial());
}
