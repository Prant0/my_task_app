import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:habiba_task_manager/features/tasks/models/task.dart';
import 'package:habiba_task_manager/features/tasks/repository/task_repository.dart';

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

  String? get selectedCategory => _selectedCategory;
  String? get selectedPriority => _selectedPriority;
  String? get selectedStatus => _selectedStatus;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void setTab(int value) {
    _tab = value;
    update();
  }

  Future<void> load() async {
    try {
      final data = await taskRepository.getAll();
      _tasks = data;
      // Apply existing filters and search after loading
      _applyFiltersAndSearch();
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> searchTasks(String query) async {
    _searchQuery = query;
    _applyFiltersAndSearch();
    update();
  }

  Future<void> filterTasks({String? category, String? priority, String? status}) async {
    _selectedCategory = category;
    _selectedPriority = priority;
    _selectedStatus = status;

    _applyFiltersAndSearch();
    update();
  }

  void _applyFiltersAndSearch() {
    if (_tasks == null) return;

    List<Task> result = List.from(_tasks!);

    // Apply filters first
    if (_selectedCategory != null || _selectedPriority != null || _selectedStatus != null) {
      result = result.where((task) {
        bool matchesCategory = _selectedCategory == null || task.category == _selectedCategory;
        bool matchesPriority = _selectedPriority == null || task.priority == _selectedPriority;
        bool matchesStatus = _selectedStatus == null || task.status == _selectedStatus;

        return matchesCategory || matchesPriority || matchesStatus;
      }).toList();
    }

    // Apply search query
    if (_searchQuery.isNotEmpty) {
      result = result.where((task) {
        return task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (task.description.toLowerCase().contains(_searchQuery.toLowerCase()));
      }).toList();
    }

    _filteredTasks = result;
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
    return filteredTasks?.where((task) => task.status == 'pending').toList() ?? [];
  }

  List<Task> getCompletedTasks() {
    return filteredTasks?.where((task) => task.status == 'completed').toList() ?? [];
  }

  void clearFilters() {
    _selectedCategory = null;
    _selectedPriority = null;
    _selectedStatus = null;
    _searchQuery = '';
    _filteredTasks = _tasks;
    update();
  }
}