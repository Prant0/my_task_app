import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:task_manager/features/tasks/models/task.dart';
import 'package:task_manager/features/tasks/repository/task_repository.dart';

class TaskController extends GetxController implements GetxService {
  final TaskRepository taskRepository;
  TaskController({required this.taskRepository});

  List<Task>? _tasks;
  List<Task>? get tasks => _tasks;

  List<Task>? _filteredTasks;
  List<Task>? get filteredTasks => _filteredTasks ?? _tasks;

  int? _tab = 0;
  int? get tab => _tab;

  String _searchQuery = '';
  String? _selectedCategory;
  String? _selectedPriority;
  String? _selectedStatus;

  void setTab(int value) {
    _tab = value;
    update();
  }

  Future<void> load() async {
    try {
      final data = await taskRepository.getAll();
      _tasks = data;
      _filteredTasks = data;
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> searchTasks(String query) async {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredTasks = _tasks;
    } else {
      _filteredTasks = await taskRepository.searchTasks(query);
    }
    update();
  }

  Future<void> filterTasks({
    String? category,
    String? priority,
    String? status,
  }) async {
    _selectedCategory = category;
    _selectedPriority = priority;
    _selectedStatus = status;

    if (category == null && priority == null && status == null) {
      _filteredTasks = _tasks;
    } else {
      _filteredTasks = await taskRepository.getTasksByFilter(
        category: category,
        priority: priority,
        status: status,
      );
    }
    update();
  }

  Future<void> toggleTaskStatus(int id, String currentStatus) async {
    if (currentStatus == 'pending') {
      await taskRepository.markAsCompleted(id);
    } else {
      await taskRepository.markAsPending(id);
    }
    await load();
  }

  Future<void> add(Task task) async {
    await taskRepository.insert(task);
    await load();
  }

  Future<void> updateTask(Task task) async {
    await taskRepository.update(task);
    await load();
  }

  Future<void> remove(int id) async {
    await taskRepository.delete(id);
    await load();
  }

  List<Task> getPendingTasks() {
    return tasks?.where((task) => task.status == 'pending').toList() ?? [];
  }

  List<Task> getCompletedTasks() {
    return tasks?.where((task) => task.status == 'completed').toList() ?? [];
  }

  void clearFilters() {
    _selectedCategory = null;
    _selectedPriority = null;
    _selectedStatus = null;
    _filteredTasks = _tasks;
    update();
  }
}