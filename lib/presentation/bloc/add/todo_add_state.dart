import 'package:equatable/equatable.dart';


abstract class TodoAddState extends Equatable {
  const TodoAddState();

  @override
  List<Object?> get props => [];
}

class TodoAddLoadingState extends TodoAddState {}

class TodoAddedState extends TodoAddState {
   const TodoAddedState();

   @override
   List<Object> get props => [];
}

class TodoAddErrorState extends TodoAddState {
  const TodoAddErrorState();
}
