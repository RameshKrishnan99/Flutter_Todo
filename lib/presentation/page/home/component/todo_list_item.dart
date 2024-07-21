import 'package:flutter/material.dart';

import '../../../../domain/entity/todo_domain.dart';

class TodoListItem extends StatelessWidget {
  final TodoEntity todoDomain;
  final Function onClickItem;
  final Function onClickDelete;
  final Function(bool?) onToggleComplete;

  const TodoListItem(
      {required this.todoDomain,
      required this.onClickItem,
      required this.onClickDelete,
      required this.onToggleComplete,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key("deleted_todo_${todoDomain.id}"),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onClickDelete();
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        onTap: () => onClickItem(),
        title: Text(
          todoDomain.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: todoDomain.isCompleted
              ? const TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        ),
        subtitle: Text(
          todoDomain.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: todoDomain.isCompleted
              ? const TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        ),
        leading: Checkbox(
          key: Key('todo_item_checkbox_${todoDomain.id}'),
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          value: todoDomain.isCompleted,
          onChanged: (bool? value) {
            onToggleComplete(value);
          },
        ),
      ),
    );
  }
}
