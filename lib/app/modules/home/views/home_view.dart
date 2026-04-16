import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_manager_trosobo/app/data/models/task_model.dart';
import 'package:task_manager_trosobo/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager"),
        actions: [
          // Tombol refresh manual di AppBar
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.fetchAllTasks(),
          )
        ],
      ),
      body: Obx(() {
        // // Tampilkan loading spinner saat sedang mengambil data
        // if (controller.isLoading.value) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        // Tampilkan pesan jika data kosong
        if (controller.tasks.isEmpty) {
          return const Center(
              child: Text("Belum ada tugas. Klik + untuk menambah."));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchAllTasks(),
          child: ListView.builder(
            itemCount: controller.tasks.length,
            itemBuilder: (context, index) {
              final task = controller.tasks[index];
              return ListTile(
                onTap: () => Get.toNamed(Routes.ADD_TASK, arguments: task)
                    ?.then((_) => controller.fetchAllTasks()),
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.status == JobStatus.done
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                subtitle: Text("Status: ${task.status.name}"),
                leading: Checkbox(
                  value: task.status == JobStatus.done,
                  onChanged: (_) => controller.toggleTaskStatus(index),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => controller.deleteTask(index),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.toNamed(Routes.ADD_TASK)
            ?.then((_) => controller.fetchAllTasks()),
      ),
    );
  }
}
