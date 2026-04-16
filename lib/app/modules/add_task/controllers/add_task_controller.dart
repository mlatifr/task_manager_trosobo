import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_trosobo/app/data/models/task_model.dart';
import 'package:task_manager_trosobo/app/data/services/task_services.dart';

class AddTaskController extends GetxController {
  TaskModel? existingTask;
  RxBool isEdit = false.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is TaskModel) {
      existingTask = Get.arguments;
      isEdit(true);
      tittleController.text = existingTask!.title;
      descriptionController.text = existingTask!.description ?? "";
      selectedDate.value = existingTask!.dueDate ?? DateTime.now();
    }
  }

  var selectedStatus = JobStatus.todo.obs; // Tambahkan ini
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

  // --- 2. FUNGSI UPDATE ---
  Future<void> updateExistingTask() async {
    try {
      // Update data di objek lokal
      existingTask!.title = tittleController.text;
      existingTask!.description = descriptionController.text;
      existingTask!.dueDate = selectedDate.value;

      // Kirim ke Service (PUT)
      bool success =
          await _taskService.updateTask(existingTask!.id!, existingTask!);

      if (success) {
        Get.back();
        Get.snackbar(
          "Sukses",
          "Tugas berhasil diperbarui",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal memperbarui tugas ke server: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
