import 'package:get/get.dart';
import 'package:task_manager/features/tasks/controller/task_controller.dart';
import 'package:task_manager/features/tasks/repository/task_repository.dart';

Future<void> init() async {
  /// Repository
  Get.lazyPut(() => TaskRepository());

  /// Controller
  Get.lazyPut(() => TaskController(taskRepository: Get.find()));
}
