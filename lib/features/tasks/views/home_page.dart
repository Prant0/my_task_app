import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habiba_task_manager/app_theme.dart';
import 'package:habiba_task_manager/features/tasks/controller/task_controller.dart';
import 'package:habiba_task_manager/features/tasks/widgets/task_card.dart';
import 'package:habiba_task_manager/features/tasks/widgets/filter_dialog.dart';
import 'package:habiba_task_manager/helper/date_converter.dart';
import 'package:habiba_task_manager/utils/dimensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(builder: (taskController) {

      final tasks = taskController.filteredTasks;
      final assigned = tasks?.where((t) => t.status == 'pending').toList() ?? [];
      final completed = tasks?.where((t) => t.status == 'completed').toList() ?? [];

      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.bg,
          surfaceTintColor: AppColors.bg,
          automaticallyImplyLeading: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateConverter.greeting(), style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: Dimensions.fontSizeTwelve)),
              Text(DateConverter.today(), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: Dimensions.fontSizeSixteen)),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list, color: AppColors.primary),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => FilterDialog(
                    currentCategory: taskController.selectedCategory,
                    currentPriority: taskController.selectedPriority,
                    currentStatus: taskController.selectedStatus,
                  ),
                );
              },
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: Dimensions.paddingSizeTwenty, right: Dimensions.paddingSizeTwenty, top: Dimensions.paddingSizeTwenty),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          taskController.searchTasks(value);
                        },
                        decoration: InputDecoration(
                          hintText: "Search tasks by name...",
                          prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                          suffixIcon: searchController.text.isNotEmpty ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();
                              taskController.searchTasks('');
                            },
                          ) : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: AppColors.card,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text("Summary", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: Dimensions.fontSizeTwenty)),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        _summaryBox(context, "Pending tasks", assigned.length, AppColors.primary),
                        const SizedBox(width: 12),

                        _summaryBox(context, "Completed tasks", completed.length, AppColors.success),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Text("Today tasks", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: Dimensions.fontSizeTwenty)),
                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(Dimensions.radiusForty),
                        border: Border.all(color: AppColors.gray.withValues(alpha: 0.33)),
                      ),
                      child: Row(
                        children: [
                          Expanded(child: _taskButton(
                            active: taskController.tab == 0,
                            text: "Pending",
                            onTap: () {
                              taskController.setTab(0);
                            },
                          )),

                          Expanded(child: _taskButton(
                            active: taskController.tab == 1,
                            text: "Completed",
                            onTap: () {
                              taskController.setTab(1);
                            },
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            tasks != null && tasks.isNotEmpty ? SliverPadding(
              padding: const EdgeInsets.only(left: Dimensions.paddingSizeTwenty, right: Dimensions.paddingSizeTwenty, top: Dimensions.paddingSizeTen),
              sliver: SliverList.separated(
                itemBuilder: (_, i) => TaskCard(task: taskController.tab == 0 ? assigned[i] : completed[i]),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemCount: taskController.tab == 0 ? assigned.length : completed.length,
              ),
            ) : SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text("No tasks available", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted)),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
          ],
        ),
      );
    });
  }

  Widget _summaryBox(BuildContext c, String label, int value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(Dimensions.paddingSizeTen),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(c).textTheme.titleMedium?.copyWith(fontSize: Dimensions.fontSizeFourteen)),
            const SizedBox(height: 10),

            Text("$value", style: Theme.of(c).textTheme.titleMedium?.copyWith(color: color, fontSize: Dimensions.fontSizeTwentyFour)),
          ],
        ),
      ),
    );
  }

  Widget _taskButton({required bool active, required String text, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.card,
          borderRadius: BorderRadius.circular(Dimensions.radiusForty),
        ),
        child: Text(text, style: TextStyle(color: active ? Colors.white : AppColors.textMuted, fontWeight: active ? FontWeight.w700 : FontWeight.w500), textAlign: TextAlign.center),
      ),
    );
  }
}
