import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/app_theme.dart';
import 'package:task_manager/common/widgets/custom_app_bar.dart';
import 'package:task_manager/common/widgets/custom_button.dart';
import 'package:task_manager/common/widgets/custom_date_picker.dart';
import 'package:task_manager/common/widgets/custom_snackbar.dart';
import 'package:task_manager/common/widgets/custom_text_field.dart';
import 'package:task_manager/features/tasks/controller/task_controller.dart';
import 'package:task_manager/features/tasks/models/task.dart';
import 'package:task_manager/utils/dimensions.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;
  final bool isEditing;
  const EditTaskPage({super.key, required this.task, this.isEditing = false});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
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
          title: widget.isEditing ? "Edit Task" : "View Task",
          actionWidget: Row(
            children: [
              if (!widget.isEditing)
                IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.primary),
                  onPressed: () {
                    Get.off(() => EditTaskPage(task: widget.task, isEditing: true));
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
                  isEnabled: widget.isEditing,
                  inputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),

                CustomTextField(
                  labelText: "Task description",
                  hintText: "Description",
                  controller: descCtrl,
                  maxLines: 5,
                  isEnabled: widget.isEditing,
                  inputAction: TextInputAction.done,
                ),
                const SizedBox(height: 10),

                if (widget.isEditing) ...[
                  Text(
                    "Priority",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.text,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedPriority,
                        items: priorities.map((String priority) {
                          return DropdownMenuItem<String>(
                            value: priority,
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: priority == 'high'
                                        ? Colors.red
                                        : priority == 'medium'
                                            ? Colors.orange
                                            : Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(priority[0].toUpperCase() + priority.substring(1)),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedPriority = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    "Category",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.text,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedCategory,
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Row(
                              children: [
                                Icon(
                                  category == 'work'
                                      ? Icons.work
                                      : category == 'personal'
                                          ? Icons.person
                                          : Icons.shopping_bag,
                                  size: 20,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(category[0].toUpperCase() + category.substring(1)),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedCategory = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ] else ...[
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
                ],

                Row(
                  children: [
                    Expanded(
                      child: CustomDatePicker(
                        labelText: "Start Date",
                        selectedDate: startDate,
                        onPicked: widget.isEditing
                            ? (date) {
                                setState(() {
                                  startDate = date;
                                });
                              }
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomDatePicker(
                        labelText: "End Date",
                        selectedDate: endDate,
                        onPicked: widget.isEditing
                            ? (date) {
                                setState(() {
                                  endDate = date;
                                });
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                if (widget.isEditing) ...[
                  CustomButton(
                    text: "Save Changes",
                    onTap: () async {
                      String title = titleCtrl.text.trim();
                      String description = descCtrl.text.trim();

                      if (title.isEmpty) {
                        showCustomSnackBar('Enter your task name');
                      } else if (description.isEmpty) {
                        showCustomSnackBar('Enter your task description');
                      } else {
                        final task = widget.task.copyWith(
                          title: title,
                          description: description,
                          priority: selectedPriority,
                          category: selectedCategory,
                          startDate: startDate,
                          endDate: endDate,
                        );
                        await taskController.updateTask(task);
                        Get.back();
                        showCustomSnackBar("Task updated successfully", isError: false);
                      }
                    },
                  ),
                ] else ...[
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: isCompleted ? "Mark as Pending" : "Mark as Completed",
                          color: isCompleted ? AppColors.primary : AppColors.success,
                          onTap: () async {
                            await taskController.toggleTaskStatus(
                              widget.task.id!,
                              widget.task.status,
                            );
                            Get.back();
                            showCustomSnackBar(
                              isCompleted
                                  ? "Task marked as pending"
                                  : "Task marked as completed",
                              isError: false,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
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