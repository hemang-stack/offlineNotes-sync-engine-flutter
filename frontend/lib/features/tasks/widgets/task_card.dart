import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_theme.dart';
import 'package:frontend/features/tasks/models/task_UI_model.dart';

class TaskCard extends StatelessWidget {
  final TaskUIModel task;
  final ValueChanged<bool?>? onCheckedChanged;
  final VoidCallback? onTap;
  final bool showTimeline;

  const TaskCard({
    Key? key,
    required this.task,
    this.onCheckedChanged,
    this.onTap,
    this.showTimeline = false,
  }) : super(key: key);

  Color _getPriorityColor() {
    switch (task.priority) {
      case TaskPriority.high:
        return AppColors.high;
      case TaskPriority.medium:
        return AppColors.medium;
      case TaskPriority.low:
        return AppColors.low;
    }
  }

  Color _getPriorityBackgroundColor() {
    switch (task.priority) {
      case TaskPriority.high:
        return AppColors.badgeHigh;
      case TaskPriority.medium:
        return AppColors.badgeMedium;
      case TaskPriority.low:
        return AppColors.badgeLow;
    }
  }

  IconData _getCategoryIcon() {
    switch (task.category?.toLowerCase()) {
      case 'design':
        return Icons.palette_rounded;
      case 'sync':
        return Icons.sync_rounded;
      case 'strategy':
        return Icons.timeline_rounded;
      default:
        return Icons.circle_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              task.isCompleted ? AppColors.surfaceVariant : AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: task.isCompleted,
                activeColor: const Color(0xFFFF7A45),
                onChanged: onCheckedChanged,
                side: const BorderSide(
                  color: AppColors.border,
                  width: 1.5,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: AppTheme.titleMedium.copyWith(
                      fontSize: 16,
                      color: task.isCompleted
                          ? AppColors.textSecondary
                          : AppColors.textPrimary,
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                      decorationColor: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          task.description ?? 'Description',  
                          style: AppTheme.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getPriorityBackgroundColor(),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    task.priority.label,
                    style: AppTheme.labelSmall.copyWith(
                      color: _getPriorityColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 10,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      task.time,
                      style: AppTheme.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
