import 'package:get/get.dart';
import 'package:task_manager_trosobo/app/data/models/task_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // .obs makes the list observable
  var tasks = <Task>[].obs;

  // Create
  void addTask(String title) {
    tasks.add(
      Task(
        id: DateTime.now().toString(),
        title: title,
        status: JobStatus.todo,
      ),
    );
  }

  // Read (Handled automatically by the observable list)

  // Update
  void toggleTaskStatus(int index) {
    var task = tasks[index];
    // task.isCompleted = !task.isCompleted;
    tasks[index] = task; // Trigger update
  }

  void editTask(int index, String newTitle) {
    var task = tasks[index];
    task.title = newTitle;
    tasks[index] = task;
  }

  // Delete
  void deleteTask(int index) {
    tasks.removeAt(index);
  }
}
