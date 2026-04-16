import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_trosobo/app/data/models/task_model.dart';
import 'package:task_manager_trosobo/app/data/services/task_services.dart';

class AddTaskController extends GetxController {
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

  final TextEditingController tittleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var selectedDate = DateTime.now().obs;
  final TaskService _taskService = TaskService();
  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(3030),
      initialEntryMode: DatePickerEntryMode.calendar,
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  addTask(String title, String description, DateTime dueDate) async {
    TaskModel newTask = TaskModel(
      title: title,
      description: description,
      dueDate: dueDate,
      status: JobStatus.todo,
    );
    try {
      final savedTask = await _taskService.createTask(newTask);

      if (savedTask != null) {
        Get.back();
        Get.snackbar(
          "Sukses",
          "Tugas berhasil ditambahkan",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal menyimpan tugas ke server: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
