import 'package:todo_list_app/models/todo_model.dart';

abstract class FetchTodoState {}

class FetchTodoInitial extends FetchTodoState {}

class EmptyPendingListState extends FetchTodoState {}

class EmptyOverdueListState extends FetchTodoState {}

class EmptyCompleteListState extends FetchTodoState {}

class SuccessfulyFetchPendingState extends FetchTodoState {
  final List<TodoModel> list;

  SuccessfulyFetchPendingState({required this.list});
}

class SuccessfulyFetchOverDueState extends FetchTodoState {
  final List<TodoModel> list;

  SuccessfulyFetchOverDueState({required this.list});
}

class SuccessfulyFetchCompleteState extends FetchTodoState {
  final List<TodoModel> list;

  SuccessfulyFetchCompleteState({required this.list});
}
