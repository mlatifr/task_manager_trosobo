import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_trosobo/app/data/models/task_model.dart';
import 'package:task_manager_trosobo/app/data/services/task_services.dart';

class HomeController extends GetxController {
  final TaskService _taskService = TaskService();
  @override
  void onInit() {
    super.onInit();
    fetchAllTasks();
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
  var tasks = <TaskModel>[].obs;

  Future<void> fetchAllTasks() async {
    try {
      var result = await _taskService.getTasks();
      if (result != null) {
        tasks.assignAll(result);
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat data dari server: $e");
    }
  }

  // Create
  void addTask(String title) {
    tasks.add(
      TaskModel(
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
  void deleteTask(int index) async {
    final taskId = tasks[index].id;

    if (taskId == null) {
      Get.snackbar("Error", "ID Tugas tidak ditemukan");
      return;
    }

    try {
      bool success = await _taskService.deleteTask(taskId);

      if (success) {
        tasks.removeAt(index);

        Get.snackbar(
          "Sukses",
          "Tugas berhasil dihapus",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black87,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal menghapus tugas dari server");
    }
  }
}
