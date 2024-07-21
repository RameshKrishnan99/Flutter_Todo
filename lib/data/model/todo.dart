import 'package:floor/floor.dart';
import 'package:flutter_todo/domain/entity/todo_domain.dart';

@Entity(tableName: 'TodoEntity')
class TodoModel extends TodoEntity {
  @override
  @PrimaryKey(autoGenerate: true)
  int? id;
  TodoModel({
    this.id,
   required String title,
   required String description,
   required bool isCompleted,
  }) : super(
          id,
          title,
          description,
          isCompleted,
        );

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
        title: entity.title,
        description: entity.description,
        isCompleted: entity.isCompleted);
  }
}
