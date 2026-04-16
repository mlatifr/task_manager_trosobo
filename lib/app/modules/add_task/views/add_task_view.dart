import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
                  controller.addTask(
                    controller.tittleController.text,
                    controller.descriptionController.text,
                    controller.selectedDate.value,
                  );
                },
                child: const Text('Simpan Tugas'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
