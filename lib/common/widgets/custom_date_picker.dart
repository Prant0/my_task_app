import 'package:flutter/material.dart';
import 'package:habiba_task_manager/app_theme.dart';
import 'package:habiba_task_manager/helper/date_converter.dart';
import 'package:habiba_task_manager/utils/dimensions.dart';

class CustomDatePicker extends StatelessWidget {
  final String labelText;
  final Function? onPicked;
  final DateTime? selectedDate;
  const CustomDatePicker({super.key, required this.labelText, required this.onPicked, this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(labelText, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: Dimensions.fontSizeFourteen)),
      ),

      InkWell(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            onPicked!(pickedDate);
          }
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeFifteen, vertical: Dimensions.paddingSizeFifteen),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusTen),
            border: Border.all(color: AppColors.bg),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Text(
                selectedDate != null ? DateConverter.formatDate(selectedDate!) : "Select Date",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: Dimensions.fontSizeTwelve, color: selectedDate != null ? AppColors.text : AppColors.textMuted),
                overflow: TextOverflow.ellipsis, maxLines: 1,
              ),
            ),

            const Icon(Icons.calendar_month_outlined, color: AppColors.primary),
          ]),
        ),
      ),

    ]);
  }
}
