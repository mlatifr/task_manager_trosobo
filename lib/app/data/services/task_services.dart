import 'package:dio/dio.dart';
import '../models/task_model.dart';

class TaskService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:3000', // Ganti dengan URL API Anda
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  // GET All Tasks
  Future<List<TaskModel>> getTasks() async {
    try {
      final response = await _dio.get('/tasks');
      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((task) => TaskModel.fromJson(task)).toList();
      }
      return [];
    } catch (e) {
      throw Exception("Gagal memuat data: $e");
    }
  }

  // POST Create Task
  Future<TaskModel?> createTask(TaskModel task) async {
    try {
      final response = await _dio.post('/tasks', data: task.toJson());
      if (response.statusCode == 201) {
        return TaskModel.fromJson(response.data);
      }
      print(response.data);
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // PUT Update Task
  Future<void> updateTask(String id, TaskModel task) async {
    try {
      await _dio.put('/tasks/$id', data: task.toJson());
    } catch (e) {
      rethrow;
    }
  }

  // DELETE Task
  Future<bool> deleteTask(int id) async {
    try {
      final response = await _dio.delete('/tasks/$id');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception("Gagal menghapus data di server: $e");
    }
  }
}
