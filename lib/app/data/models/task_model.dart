class Task {
  String id;
  String title;
  String? description;
  JobStatus status;
  DateTime? dueDate;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.dueDate,
    required this.status,
  });
}

enum JobStatus { todo, inProgress, done }
