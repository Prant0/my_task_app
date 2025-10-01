import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/app_theme.dart';
import 'package:task_manager/features/tasks/models/task.dart';
import 'package:task_manager/features/tasks/views/view_task_page.dart';
import 'package:task_manager/helper/date_converter.dart';
import 'package:task_manager/utils/dimensions.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final statusColor = task.status == 'completed' ? AppColors.success : AppColors.primary;
    final statusText = task.status == 'completed' ? 'Completed' : 'Pending';
    final priorityColor = task.priority == 'high' ? Colors.red : task.priority == 'medium' ? Colors.orange : Colors.green;
    final categoryIcon = task.category == 'work' ? Icons.work : task.category == 'personal' ? Icons.person : Icons.shopping_bag;

    return InkWell(
      onTap: () {
        Get.to(() => ViewTaskPage(task: task));
      },
      child: Container(
        padding: const EdgeInsets.all(Dimensions.paddingSizeTen),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(Dimensions.radiusTen),
          border: Border.all(color: AppColors.gray.withValues(alpha: 0.33)),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 12, offset: const Offset(0,6))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: Dimensions.fontSizeSixteen),
              maxLines: 2, overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),

            Text(
              task.description, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: Dimensions.fontSizeTwelve),
              maxLines: 2, overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: priorityColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: priorityColor.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: priorityColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        task.priority[0].toUpperCase() + task.priority.substring(1),
                        style: TextStyle(
                          fontSize: 10,
                          color: priorityColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.chipBg,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(categoryIcon, size: 12, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        task.category[0].toUpperCase() + task.category.substring(1),
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.text,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.timer_outlined, size: 16, color: AppColors.text),
                const SizedBox(width: 8),

                Text(DateConverter.formatDate(task.endDate!), style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: Dimensions.fontSizeTwelve)),
                const Spacer(),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(Dimensions.radiusForty),
                  ),
                  child: Text(statusText, style: TextStyle(color: statusColor, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
