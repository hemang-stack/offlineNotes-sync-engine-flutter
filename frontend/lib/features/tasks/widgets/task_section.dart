import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_theme.dart';
import 'package:frontend/features/tasks/models/task_UI_model.dart';
import 'task_card.dart';
import 'timeline_indicator.dart';

class TaskSection extends StatelessWidget {
  final String title;
  final List<TaskUIModel> tasks;
  final bool showTimeline;
  final ValueChanged<TaskUIModel>? onTaskChecked;
  final ValueChanged<TaskUIModel>? onTaskTap;

  const TaskSection({
    Key? key,
    required this.title,
    required this.tasks,
    this.showTimeline = true,
    this.onTaskChecked,
    this.onTaskTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            title,
            style: AppTheme.titleLarge.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
        if (showTimeline)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: List.generate(
                  tasks.length,
                  (index) => TimelineIndicator(
                    isFirst: index == 0,
                    isLast: index == tasks.length - 1,
                    isCompleted: tasks[index].isCompleted,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: List.generate(
                    tasks.length,
                    (index) => TaskCard(
                      task: tasks[index],
                      onCheckedChanged: (value) {
                        if (value != null) {
                          onTaskChecked?.call(tasks[index]);
                        }
                      },
                      onTap: () => onTaskTap?.call(tasks[index]),
                    ),
                  ),
                ),
              ),
            ],
          )
        else
          Column(
            children: List.generate(
              tasks.length,
              (index) => TaskCard(
                task: tasks[index],
                onCheckedChanged: (value) {
                  if (value != null) {
                    onTaskChecked?.call(tasks[index]);
                  }
                },
                onTap: () => onTaskTap?.call(tasks[index]),
              ),
            ),
          ),
      ],
    );
  }
}