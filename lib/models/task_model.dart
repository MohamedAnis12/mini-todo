class TaskModel {
  int? id;
  String title;
  String description;
  //String date;
  bool isDone;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    // this.date = "",
    this.isDone = false,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int,
      title: map['title'],
      description: map['description'],
      isDone: (map['isDone'] as int) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone ? 1 : 0,
    };
  }
}
