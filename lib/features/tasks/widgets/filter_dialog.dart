import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habiba_task_manager/app_theme.dart';
import 'package:habiba_task_manager/features/tasks/controller/task_controller.dart';

class FilterDialog extends StatefulWidget {
  final String? currentCategory;
  final String? currentPriority;
  final String? currentStatus;

  const FilterDialog({
    super.key,
    this.currentCategory,
    this.currentPriority,
    this.currentStatus,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? selectedCategory;
  String? selectedPriority;
  String? selectedStatus;

  final List<String> categories = ['All', 'work', 'personal', 'shopping'];
  final List<String> priorities = ['All', 'high', 'medium', 'low'];
  final List<String> statuses = ['All', 'pending', 'completed'];

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.currentCategory;
    selectedPriority = widget.currentPriority;
    selectedStatus = widget.currentStatus;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(builder: (taskController) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Filter Tasks"),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Category",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: categories.map((category) {
                  final isSelected = selectedCategory == category ||
                      (category == 'All' && selectedCategory == null);
                  return FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (category != 'All')
                          Icon(
                            category == 'work'
                                ? Icons.work
                                : category == 'personal'
                                ? Icons.person
                                : Icons.shopping_bag,
                            size: 16,
                          ),
                        if (category != 'All') const SizedBox(width: 4),
                        Text(category == 'All'
                            ? category
                            : category[0].toUpperCase() + category.substring(1)),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedCategory = category == 'All' ? null : category;
                      });
                    },
                    selectedColor: AppColors.primary.withValues(alpha: 0.2),
                    checkmarkColor: AppColors.primary,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Text(
                "Priority",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: priorities.map((priority) {
                  final isSelected = selectedPriority == priority ||
                      (priority == 'All' && selectedPriority == null);
                  final priorityColor = priority == 'high'
                      ? Colors.red
                      : priority == 'medium'
                      ? Colors.orange
                      : priority == 'low'
                      ? Colors.green
                      : AppColors.primary;
                  return FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (priority != 'All')
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: priorityColor,
                            ),
                          ),
                        if (priority != 'All') const SizedBox(width: 4),
                        Text(priority == 'All'
                            ? priority
                            : priority[0].toUpperCase() + priority.substring(1)),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedPriority = priority == 'All' ? null : priority;
                      });
                    },
                    selectedColor: priorityColor.withValues(alpha: 0.2),
                    checkmarkColor: priorityColor,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Text(
                "Status",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: statuses.map((status) {
                  final isSelected = selectedStatus == status ||
                      (status == 'All' && selectedStatus == null);
                  final statusColor = status == 'completed'
                      ? AppColors.success
                      : status == 'pending'
                      ? AppColors.primary
                      : AppColors.text;
                  return FilterChip(
                    label: Text(status == 'All'
                        ? status
                        : status[0].toUpperCase() + status.substring(1)),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedStatus = status == 'All' ? null : status;
                      });
                    },
                    selectedColor: statusColor.withValues(alpha: 0.2),
                    checkmarkColor: statusColor,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedCategory = null;
                selectedPriority = null;
                selectedStatus = null;
              });
              taskController.clearFilters();
            },
            child: const Text("Clear All"),
          ),
          FilledButton(
            onPressed: () {
              taskController.filterTasks(
                category: selectedCategory,
                priority: selectedPriority,
                status: selectedStatus,
              );
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text("Apply Filter"),
          ),
        ],
      );
    });
  }
}