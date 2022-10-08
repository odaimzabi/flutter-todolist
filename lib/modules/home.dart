// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:todolist/constants/colors.dart';
import 'package:todolist/widgets/todo_item.dart';

import '../models/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.getTodos();
  final _todoController = TextEditingController();
  List<ToDo> foundTodos = [];

  @override
  void initState() {
    foundTodos = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: Text('All Todos',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500)),
                      ),
                      for (ToDo todo in foundTodos)
                        TodoItem(
                          todo: todo,
                          onTodoChanged: _handleTodoChange,
                          onDeleteItem: _handleDeleteTodo,
                        )
                    ],
                  ),
                )
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            spreadRadius: 0.0,
                            blurRadius: 10.0)
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        hintText: "Add a new todo item.",
                        border: InputBorder.none),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    child: Text("+", style: TextStyle(fontSize: 40)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        minimumSize: Size(30, 30),
                        elevation: 10),
                    onPressed: () {
                      _handleAddTodo(_todoController.text);
                    },
                  ),
                )
              ]),
            )
          ],
        ));
  }

  void _handleTodoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDeleteTodo(ToDo todo) {
    setState(() {
      todosList.removeWhere((t) => t.id == todo.id);
    });
  }

  void _handleAddTodo(String text) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          todoText: text));
    });
    _todoController.clear();
  }

  void _handleSearch(String value) {
    List<ToDo> results = [];
    if (value.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) =>
              item.todoText!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      foundTodos = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextField(
              onChanged: (value) => _handleSearch(value),
              decoration: const InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  prefixIconConstraints:
                      const BoxConstraints(maxHeight: 20, maxWidth: 20),
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: tdGrey),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: tdBlack,
                    size: 20,
                  )),
            ),
          )
        ],
      ),
    );
  }
}

AppBar _buildAppBar() {
  return AppBar(
    backgroundColor: tdBGColor,
    elevation: 0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.menu, color: tdBlack, size: 30),
        SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.jpeg'),
            ))
      ],
    ),
  );
}
