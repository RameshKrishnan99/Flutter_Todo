import 'package:equatable/equatable.dart';


abstract class TodoDeleteState extends Equatable {
  const TodoDeleteState();

  @override
  List<Object?> get props => [];
}

class TodoDeleteLoadingState extends TodoDeleteState {}

class TodoDeletedState extends TodoDeleteState {
   const TodoDeletedState();

   @override
   List<Object> get props => [];
}

class TodoDeleteErrorState extends TodoDeleteState {
  const TodoDeleteErrorState();
}
