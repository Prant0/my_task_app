import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habiba_task_manager/app_theme.dart';
import 'package:habiba_task_manager/features/tasks/models/task.dart';
import 'package:habiba_task_manager/features/tasks/views/view_task_page.dart';
import 'package:habiba_task_manager/helper/date_converter.dart';
import 'package:habiba_task_manager/utils/dimensions.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {


  String getRemainingTime() {

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });

    final now = DateTime.now();
    final endDate = widget.task.endDate!;
    final remainingTime = endDate.difference(now);
    final days = remainingTime.inDays;
    final hours = remainingTime.inHours % 24;
    final minutes = remainingTime.inMinutes % 60;
    final seconds = remainingTime.inSeconds % 60;
    return '$days D : $hours H : $minutes M : $seconds s';
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = widget.task.status == 'completed' ? AppColors.success : AppColors.primary;
    final statusText = widget.task.status == 'completed' ? 'Completed' : 'Pending';
    final priorityColor = widget.task.priority == 'high' ? Colors.red : widget.task.priority == 'medium' ? Colors.orange : Colors.green;
    final categoryIcon = widget.task.category == 'work' ? Icons.work : widget.task.category == 'personal' ? Icons.person : Icons.shopping_bag;

    return InkWell(
      onTap: () {
        Get.to(() => ViewTaskPage(task: widget.task));
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.task.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: Dimensions.fontSizeFifteen),
                    maxLines: 2, overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(Dimensions.radiusForty),
                  ),
                  child: Text(statusText, style: TextStyle(color: statusColor, fontWeight: FontWeight.w700, fontSize: Dimensions.fontSizeTwelve)),
                ),
              ],
            ),
            const SizedBox(height: 5),

            Text(
              widget.task.description, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: Dimensions.fontSizeTwelve, color: AppColors.text.withValues(alpha: 0.7)),
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
                        widget.task.priority[0].toUpperCase() + widget.task.priority.substring(1),
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
                        widget.task.category[0].toUpperCase() + widget.task.category.substring(1),
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
            const SizedBox(height: 15),

            Row(
              children: [
                const Icon(Icons.timer_outlined, size: 16, color: AppColors.text),
                const SizedBox(width: 8),

                Text(DateConverter.formatDate(widget.task.endDate!),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: Dimensions.fontSizeTwelve, color: AppColors.text.withValues(alpha: 0.7))),
                const Spacer(),

                Text(getRemainingTime(), style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: Dimensions.fontSizeTwelve, color: AppColors.text.withValues(alpha: 0.7))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
