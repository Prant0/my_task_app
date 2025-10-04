import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habiba_task_manager/app_theme.dart';
import 'package:habiba_task_manager/common/widgets/custom_app_bar.dart';
import 'package:habiba_task_manager/common/widgets/custom_button.dart';
import 'package:habiba_task_manager/common/widgets/custom_date_picker.dart';
import 'package:habiba_task_manager/common/widgets/custom_snackbar.dart';
import 'package:habiba_task_manager/common/widgets/custom_text_field.dart';
import 'package:habiba_task_manager/features/tasks/controller/task_controller.dart';
import 'package:habiba_task_manager/features/tasks/models/task.dart';
import 'package:habiba_task_manager/utils/dimensions.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime? endDate;
  String selectedPriority = 'medium';
  String selectedCategory = 'personal';

  final List<String> priorities = ['high', 'medium', 'low'];
  final List<String> categories = ['work', 'personal', 'shopping'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        title: "Create new task",
      ),
      body: GetBuilder<TaskController>(builder: (taskController) {
        return SingleChildScrollView(
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
                  inputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),

                CustomTextField(
                  labelText: "Task description",
                  hintText: "Description",
                  controller: descCtrl,
                  maxLines: 5,
                  inputAction: TextInputAction.done,
                ),
                const SizedBox(height: 10),

                Text(
                  "Priority",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: Dimensions.fontSizeFourteen),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(Dimensions.radiusTen),
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
                              Text(priority[0].toUpperCase() + priority.substring(1),
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: Dimensions.fontSizeTwelve, color: AppColors.text)),
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: Dimensions.fontSizeFourteen),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(Dimensions.radiusTen),
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
                              Text(category[0].toUpperCase() + category.substring(1),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: Dimensions.fontSizeTwelve, color: AppColors.text)),
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

                Row(
                  children: [
                    Expanded(
                      child: CustomDatePicker(
                        labelText: "Start Date",
                        selectedDate: startDate,
                        onPicked: (date) {
                          setState(() {
                            startDate = date;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomDatePicker(
                        labelText: "End Date",
                        selectedDate: endDate,
                        onPicked: (date) {
                          setState(() {
                            endDate = date;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                CustomButton(
                  text: "Create new tasks",
                  onTap: () async {

                    String title = titleCtrl.text.trim();
                    String description = descCtrl.text.trim();

                    if (title.isEmpty) {
                      showCustomSnackBar('Enter your task name');
                    } else if (description.isEmpty) {
                      showCustomSnackBar('Enter your task description');
                    } /*else if (startDate == null) {
                      showCustomSnackBar('Select start date');
                    } */else if (endDate == null) {
                      showCustomSnackBar('Select end date');
                    } else if (endDate!.isBefore(startDate)) {
                      showCustomSnackBar('End date must be after start date');
                    } else {
                      await taskController.add(
                        Task(
                          title: title,
                          description: description,
                          priority: selectedPriority,
                          category: selectedCategory,
                          startDate: startDate,
                          endDate: endDate ?? DateTime.now(),
                          status: 'pending',
                        ),
                      ).then((value) {
                        titleCtrl.clear();
                        descCtrl.clear();
                        setState(() {
                          startDate = DateTime.now();
                          endDate = null;
                          selectedPriority = 'medium';
                          selectedCategory = 'personal';
                        });
                      });
                      Get.back();
                      showCustomSnackBar('Task created successfully', isError: false);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}