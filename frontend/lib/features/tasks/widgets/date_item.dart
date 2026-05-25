import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_theme.dart';

class DateItem extends StatelessWidget {
  final int day;
  final String dayOfWeek;
  final bool isSelected;
  final VoidCallback onTap;

  const DateItem({
    Key? key,
    required this.day,
    required this.dayOfWeek,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 64,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day.toString().padLeft(2, '0'),
                style: AppTheme.titleMedium.copyWith(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dayOfWeek,
                style: AppTheme.bodySmall.copyWith(
                  color: isSelected ? Colors.white70 : AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
