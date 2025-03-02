import 'package:todo_list_app/models/todo_model.dart';

abstract class FetchTodoState {}

class FetchTodoInitial extends FetchTodoState {}

class EmptyListState extends FetchTodoState {}

class SuccessfulyFetchState extends FetchTodoState {
  final List<TodoModel> list;

  SuccessfulyFetchState({required this.list});
}
