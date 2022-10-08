import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';

import '../constants/colors.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final onTodoChanged;
  final onDeleteItem;
  const TodoItem(
      {Key? key,
      required this.todo,
      required this.onDeleteItem,
      required this.onTodoChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChanged(todo);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: todo.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              color: tdRed, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            icon: Icon(Icons.delete),
            color: Colors.white,
            iconSize: 18,
            onPressed: () {
              onDeleteItem(todo);
            },
          ),
        ),
      ),
    );
  }
}
