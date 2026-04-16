class TaskModel {
  int? id;
  String title;
  String? description;
  JobStatus status;
  DateTime? dueDate;

  TaskModel({
    this.id,
    required this.title,
    this.description,
    this.dueDate,
    required this.status,
  });

  // Konversi dari JSON (API -> App)
  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        dueDate:
            json["dueDate"] != null ? DateTime.parse(json["dueDate"]) : null,
        status: JobStatus.values
            .firstWhere((e) => e.toString().split('.').last == json["status"]),
      );

  // Konversi ke JSON (App -> API)
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "dueDate": dueDate?.toIso8601String(),
        "status": status.name, // Mengambil string dari enum (todo, done, dll)
      };
}

enum JobStatus { todo, inProgress, done }
