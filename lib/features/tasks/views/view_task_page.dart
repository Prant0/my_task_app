import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habiba_task_manager/common/widgets/custom_app_bar.dart';
import 'package:habiba_task_manager/common/widgets/custom_snackbar.dart';
import 'package:habiba_task_manager/features/tasks/controller/task_controller.dart';
import 'package:habiba_task_manager/features/tasks/views/edit_task_page.dart';
import 'package:habiba_task_manager/utils/dimensions.dart';
import 'package:habiba_task_manager/app_theme.dart';
import 'package:habiba_task_manager/common/widgets/custom_button.dart';
import 'package:habiba_task_manager/common/widgets/custom_date_picker.dart';
import 'package:habiba_task_manager/common/widgets/custom_text_field.dart';
import 'package:habiba_task_manager/features/tasks/models/task.dart';

class ViewTaskPage extends StatefulWidget {
  final Task task;
  const ViewTaskPage({super.key, required this.task});

  @override
  State<ViewTaskPage> createState() => _ViewTaskPageState();
}

class _ViewTaskPageState extends State<ViewTaskPage> {
  late TextEditingController titleCtrl;
  late TextEditingController descCtrl;
  late DateTime? startDate;
  late DateTime? endDate;
  late String selectedPriority;
  late String selectedCategory;
  late bool isCompleted;

  final List<String> priorities = ['high', 'medium', 'low'];
  final List<String> categories = ['work', 'personal', 'shopping'];

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.task.title);
    descCtrl = TextEditingController(text: widget.task.description);
    startDate = widget.task.startDate;
    endDate = widget.task.endDate;
    selectedPriority = widget.task.priority;
    selectedCategory = widget.task.category;
    isCompleted = widget.task.status == 'completed';
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(builder: (taskController) {
      return Scaffold(
        appBar: CustomAppBar(
          title: "View Task",
          actionWidget: Row(
            children: [
              isCompleted ? SizedBox() : IconButton(
                icon: const Icon(Icons.edit, color: AppColors.primary),
                onPressed: () {
                  Get.to(() => EditTaskPage(task: widget.task));
                },
              ),

              IconButton(
                icon: const Icon(Icons.delete, color: AppColors.error),
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => DeleteConfirmDialog(
                      onDelete: () async {
                        if (widget.task.id != null) {
                          await taskController.remove(widget.task.id!);
                          Get.back();
                          Get.back();
                          showCustomSnackBar("Task deleted successfully", isError: false);
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
            margin: const EdgeInsets.symmetric(vertical: Dimensions.marginSizeTen),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(Dimensions.radiusFifteen),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  labelText: "Task Name",
                  hintText: "Enter Your Task Name",
                  controller: titleCtrl,
                  isEnabled: false,
                  inputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),

                CustomTextField(
                  labelText: "Task description",
                  hintText: "Description",
                  controller: descCtrl,
                  maxLines: 5,
                  isEnabled: false,
                  inputAction: TextInputAction.done,
                ),
                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.chipBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Priority: ",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: (selectedPriority == 'high'
                                  ? Colors.red
                                  : selectedPriority == 'medium'
                                  ? Colors.orange
                                  : Colors.green)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: (selectedPriority == 'high'
                                    ? Colors.red
                                    : selectedPriority == 'medium'
                                    ? Colors.orange
                                    : Colors.green)
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              selectedPriority[0].toUpperCase() + selectedPriority.substring(1),
                              style: TextStyle(
                                color: selectedPriority == 'high'
                                    ? Colors.red
                                    : selectedPriority == 'medium'
                                    ? Colors.orange
                                    : Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "Category: ",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  selectedCategory == 'work'
                                      ? Icons.work
                                      : selectedCategory == 'personal'
                                      ? Icons.person
                                      : Icons.shopping_bag,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  selectedCategory[0].toUpperCase() + selectedCategory.substring(1),
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: CustomDatePicker(
                        labelText: "Start Date",
                        selectedDate: startDate,
                        onPicked: null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomDatePicker(
                        labelText: "End Date",
                        selectedDate: endDate,
                        onPicked: null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isCompleted ? 0 : 40),

                isCompleted ? const SizedBox() : Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: "Mark as Completed",
                        color: AppColors.success,
                        onTap: () async {
                          await taskController.toggleTaskStatus(
                            widget.task.id!,
                            widget.task.status,
                          );
                          Get.back();
                          showCustomSnackBar("Task marked as completed", isError: false);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class DeleteConfirmDialog extends StatelessWidget {
  final VoidCallback onDelete;
  const DeleteConfirmDialog({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Task"),
      content: const Text("Are you sure you want to delete this task? This action cannot be undone."),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: onDelete,
          style: TextButton.styleFrom(
            backgroundColor: AppColors.error.withValues(alpha: 0.1),
            foregroundColor: AppColors.error,
          ),
          child: const Text("Delete"),
        ),
      ],
    );
  }
}