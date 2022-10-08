class ToDo {
  String? id;
  String? todoText;
  bool isDone;
  ToDo({required this.id, required this.todoText, this.isDone = false});

  static List<ToDo> getTodos() {
    return [
      ToDo(id: "1", todoText: 'Check mail', isDone: true),
      ToDo(id: "2", todoText: 'Clean house'),
      ToDo(id: "3", todoText: 'Throw garbage'),
      ToDo(id: "4", todoText: 'Do some coding'),
      ToDo(id: "5", todoText: 'Check mail again'),
    ];
  }
}
