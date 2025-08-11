class Task {
  final String name;
  bool isDone;

  Task({required this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'isDone': isDone,
  };

  factory Task.fromMap(Map<dynamic, dynamic> map) {
    return Task(
      name: map['name'] as String,
      isDone: map['isDone'] as bool,
    );
  }
}
