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

                Row(
                  children: [
                    Expanded(
                      child: CustomDatePicker(
                        labelText: "Start Date",
                        selectedDate: startDate,
                        onPicked: (date) {

                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomDatePicker(
                        labelText: "End Date",
                        selectedDate: endDate,
                        onPicked: (date) {

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
                    } else if (startDate == null) {
                      showCustomSnackBar('Select start date');
                    } else if (endDate == null) {
                      showCustomSnackBar('Select end date');
                    } else if (endDate!.isBefore(startDate!)) {
                      showCustomSnackBar('End date must be after start date');
                    } else {
                      await taskController.add(
                        Task(
                          title: title,
                          description: description,
                          startDate: startDate,
                          endDate: endDate ?? DateTime.now(),
                          status: 'todo',
                        ),
                      );
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