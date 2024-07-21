import 'package:equatable/equatable.dart';


abstract class TodoUpdateState extends Equatable {
  const TodoUpdateState();

  @override
  List<Object?> get props => [];
}

class TodoUpdateLoadingState extends TodoUpdateState {}

class TodoUpdatedState extends TodoUpdateState {
   const TodoUpdatedState();

   @override
   List<Object> get props => [];
}

class TodoUpdateErrorState extends TodoUpdateState {
  const TodoUpdateErrorState();
}
