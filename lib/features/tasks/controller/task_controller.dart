import 'package:get/get.dart';
import 'package:task_manager/features/tasks/models/task.dart';
import 'package:task_manager/features/tasks/repository/task_repository.dart';

class TaskController extends GetxController implements GetxService {
  final TaskRepository taskRepository;
  TaskController({required this.taskRepository});

  List<Task>? _tasks;
  List<Task>? get tasks => _tasks;

  int? _tab = 0;
  int? get tab => _tab;

  void setTab(int value) {
    _tab = value;
    update();
  }

  Future<void> load() async {
    try {
      final data = await taskRepository.getAll();
      _tasks = data;
    } catch (e, st) {
      print(e, );
    }
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
}