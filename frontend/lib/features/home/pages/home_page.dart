import 'package:flutter/material.dart';
import 'package:frontend/features/tasks/models/task_UI_model.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

import '../widgets/curator_appbar.dart';
import '../widgets/empty_tasks.dart';
import '../widgets/task_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    /// TEMP MOCK TASKS
    final tasks = <TaskUIModel>[
      TaskUIModel(
        id: '1',
        title: 'Refine interaction architecture',
        description:
            'Refine interaction architecture and improve overall motion consistency throughout the Curator experience.',
        priority: TaskPriority.urgent,
        scheduledAt: DateTime.now(),
        category: 'creative',
      ),

      TaskUIModel(
        id: '2',
        title: 'Prepare product launch deck',
        description:
            'Prepare launch deck and align all stakeholders before presentation.',
        priority: TaskPriority.focused,
        scheduledAt: DateTime.now(),
        category: 'deep_work',
      ),

      TaskUIModel(
        id: '3',
        title: 'Moodboard exploration session',
        description:
            'Collect references and build visual direction for upcoming project.',
        priority: TaskPriority.chill,
        scheduledAt: DateTime.now(),
        category: 'creative',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 18),

              /// APPBAR
              const CuratorAppbar(),

              const SizedBox(height: 46),

              /// HEADER
              const FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,

                child: Text(
                  "good evening.",

                  style: TextStyle(
                    color:
                        AppColors.textPrimary,

                    fontSize: 40,

                    fontWeight:
                        FontWeight.w700,

                    letterSpacing: -2,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "${tasks.length} ITEMS AWAITING CURATION",

                style: const TextStyle(
                  color:
                      AppColors.primarySoft,

                  fontSize: 10,

                  letterSpacing: 3,

                  fontWeight:
                      FontWeight.w600,
                ),
              ),

              const SizedBox(height: 36),

              /// TASKS
              Expanded(
                child: tasks.isEmpty
                    ? const EmptyTasks()
                    : ListView.separated(
                        physics:
                            const BouncingScrollPhysics(),

                        itemCount: tasks.length,

                        separatorBuilder:
                            (_, __) =>
                                const SizedBox(
                          height: 18,
                        ),

                        itemBuilder:
                            (context, index) {

                          final task =
                              tasks[index];

                          return TaskCard(
                            task: task,

                            title:
                                task.title,

                            subtitle:
                                "${task.priority.name.toUpperCase()} • ${task.time}",

                            completed:
                                task.isCompleted,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
