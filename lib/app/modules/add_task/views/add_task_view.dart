import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_manager_trosobo/app/data/models/task_model.dart';

import '../controllers/add_task_controller.dart';

class AddTaskView extends GetView<AddTaskController> {
  const AddTaskView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Tugas Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.tittleController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Nama Tugas',
                hintText: 'Masukkan judul tugas...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.descriptionController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                hintText: 'deskripsi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // --- DROPDOWN STATUS (Hanya Muncul Saat Edit) ---
            if (controller.isEdit.isTrue) ...[
              const Text("Status Tugas",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Obx(() => DropdownButtonFormField<JobStatus>(
                    value: controller.selectedStatus.value,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    items: JobStatus.values.map((JobStatus status) {
                      return DropdownMenuItem<JobStatus>(
                        value: status,
                        child: Text(status.name.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (val) => controller.selectedStatus.value = val!,
                  )),
              const SizedBox(height: 20),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.chooseDate(),
              child: Text("Select Date"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.isEdit.isTrue) {
                    controller.updateExistingTask();
                  } else {
                    controller.addTask(
                      controller.tittleController.text,
                      controller.descriptionController.text,
                      controller.selectedDate.value,
                    );
                  }
                },
                child: Obx(() {
                  return Text(controller.isEdit.isTrue
                      ? 'update tugas'
                      : 'Simpan Tugas');
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
