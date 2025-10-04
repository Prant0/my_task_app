import 'package:flutter/material.dart';
import 'package:habiba_task_manager/app_theme.dart';
import 'package:habiba_task_manager/utils/dimensions.dart';

class FancyBottomBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;
  const FancyBottomBar({super.key, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(Dimensions.radiusForty),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 16, offset: const Offset(0,8))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: _BottomNavItem(icon: Icons.home_rounded, index: 0, selectedIndex: index, onTap: onTap)),
            Expanded(child: _BottomNavItem(icon: Icons.assignment_rounded, index: 1, selectedIndex: index, onTap: onTap)),
            Expanded(child: _BottomNavItem(icon: Icons.calendar_month_rounded, index: 2, selectedIndex: index, onTap: onTap)),
            Expanded(child: _BottomNavItem(icon: Icons.settings, index: 3, selectedIndex: index, onTap: onTap)),
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const _BottomNavItem({required this.icon, required this.index, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final selected = selectedIndex == index;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      borderRadius: BorderRadius.circular(Dimensions.radiusForty),
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.all(Dimensions.marginSizeFive),
        decoration: BoxDecoration(
          color: selected ? AppColors.chipBg : Colors.transparent,
          borderRadius: BorderRadius.circular(Dimensions.radiusForty),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            icon,
            key: ValueKey('$index-$selected'),
            color: selected ? AppColors.primary : AppColors.gray,
          ),
        ),
      ),
    );
  }
}
