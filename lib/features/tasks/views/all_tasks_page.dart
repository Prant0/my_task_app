import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/app_theme.dart';
import 'package:task_manager/common/widgets/custom_app_bar.dart';
import 'package:task_manager/features/tasks/controller/task_controller.dart';
import 'package:task_manager/features/tasks/views/create_task_page.dart';
import 'package:task_manager/features/tasks/widgets/date_chips_row.dart';
import 'package:task_manager/features/tasks/widgets/task_card.dart';
import 'package:task_manager/utils/dimensions.dart';

class AllTasksPage extends StatelessWidget {
  const AllTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "All Task",
        automaticallyImplyLeading: false,
        actionWidget: Row(children: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeFifteen),
            ),
            onPressed: () async {
              Get.to(() => const CreateTaskPage());
            },
            child: Text("Create New", style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: Dimensions.fontSizeTwelve, color: AppColors.primary)),
          ),

          const SizedBox(width: 20),
        ]),
      ),
      body: GetBuilder<TaskController>(builder: (taskController) {

        final tasks = taskController.tasks;

        return Column(
          children: [
            SizedBox(height: Dimensions.paddingSizeFifteen),

            const DateChipsRow(),

            Expanded(
              child: tasks != null && tasks.isNotEmpty ? ListView.separated(
                padding: const EdgeInsets.only(left: Dimensions.paddingSizeTwenty, right: Dimensions.paddingSizeTwenty, top: Dimensions.paddingSizeTen),
                itemBuilder: (_, i) => TaskCard(task: tasks[i]),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemCount: tasks?.length ?? 0,
              ) : Center(
                child: Text("No tasks available", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted)),
              ),
            ),
          ],
        );
      }),
    );
  }
}
