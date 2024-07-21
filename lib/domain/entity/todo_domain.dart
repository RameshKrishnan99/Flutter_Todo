import 'package:floor/floor.dart';

class TodoEntity {
  @ignore
  final int? id;
  final String title;
  final String description;
  bool isCompleted;
  TodoEntity(this.id, this.title, this.description, this.isCompleted);

  @override
  List<Object?> get props => [id,title,description,isCompleted];
}
