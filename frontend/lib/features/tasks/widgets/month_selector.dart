import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_theme.dart';


class MonthSelector extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const MonthSelector({
    Key? key,
    required this.selectedDate,
    required this.onPreviousMonth,
    required this.onNextMonth,
  }) : super(key: key);

  String _getMonthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return monthNames[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final monthName = _getMonthName(selectedDate.month);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Tasks',
                style: AppTheme.headlineLarge,
              ),
              const SizedBox(height: 2),
              Text(
                monthName.toUpperCase(),
                style: AppTheme.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildNavigationButton(
                onTap: onPreviousMonth,
                icon: Icons.chevron_left_rounded,
              ),
              const SizedBox(width: 8),
              _buildNavigationButton(
                onTap: onNextMonth,
                icon: Icons.chevron_right_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton({
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.surfaceVariant,
            border: Border.all(
              color: AppColors.border,
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: AppColors.textPrimary,
            size: 18,
          ),
        ),
      ),
    );
  }
}
