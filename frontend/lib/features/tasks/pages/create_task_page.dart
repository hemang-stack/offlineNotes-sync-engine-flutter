import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend/features/tasks/models/task_UI_model.dart';
import 'package:frontend/features/tasks/widgets/create_task/task_description_input.dart';

import '../../../core/common/widgets/curator_button.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/common/widgets/glass_container.dart';

import '../widgets/create_task/create_task_header.dart';
import '../widgets/create_task/info_card.dart';
import '../widgets/create_task/moodboard_card.dart';
import '../widgets/create_task/selector_section.dart';
import '../widgets/create_task/task_title_input.dart';

class CreateTaskPage extends StatefulWidget {
  final TaskUIModel? task;
  final bool isEdit;

  const CreateTaskPage({
    super.key,
    this.task,
    this.isEdit = false,
  });

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isEdit && widget.task != null) {
      titleController.text = widget.task!.title;

      descriptionController.text = widget.task!.description ?? '';

      selectedPriority = widget.task!.priority.name.toLowerCase();

      selectedCategory = widget.task!.category ?? 'creative';

      selectedDate = widget.task!.scheduledAt;

      selectedTime = TimeOfDay(
        hour: widget.task!.scheduledAt.hour,
        minute: widget.task!.scheduledAt.minute,
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  /// PRIORITY
  String selectedPriority = 'chill';

  /// CATEGORY
  String selectedCategory = 'creative';

  /// DATE
  DateTime selectedDate = DateTime.now();

  /// TIME
  TimeOfDay selectedTime = TimeOfDay.now();

  /// PICK DATE
  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  /// PICK TIME
  Future<void> pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  /// FORMAT DATE
  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.35),
      resizeToAvoidBottomInset: true,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(
              AppRadius.lg,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * .92,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface.withOpacity(.9),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(
                    AppRadius.lg,
                  ),
                ),
                border: Border.all(
                  color: AppColors.border,
                  width: .5,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 14),

                  /// DRAG HANDLE
                  Container(
                    width: 46,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(
                        AppRadius.full,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// HEADER
                  CreateTaskHeader(
                    isEdit: widget.isEdit,
                  ),

                  /// SCROLLABLE CONTENT
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 28),

                          /// TITLE INPUT
                          TaskTitleInput(
                            titleController: titleController,
                          ),
                          const SizedBox(height: 24),

                          GlassContainer(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 24,
                              top: 12,
                              bottom: 20,
                            ),
                            child: TaskDescriptionInput(
                              descriptionController: descriptionController,
                            ),
                          ),

                          const SizedBox(height: 42),

                          /// PRIORITY
                          SelectorSection(
                            title: "priority_level",
                            chips: const [
                              "chill",
                              "focused",
                              "urgent",
                            ],
                            selectedValue: selectedPriority,
                            onSelected: (value) {
                              setState(() {
                                selectedPriority = value;
                              });
                            },
                          ),

                          const SizedBox(height: 36),

                          /// CATEGORY
                          SelectorSection(
                            title: "category_tag",
                            chips: const [
                              "creative",
                              "deep_work",
                              "admin",
                              "social",
                            ],
                            selectedValue: selectedCategory,
                            onSelected: (value) {
                              setState(() {
                                selectedCategory = value;
                              });
                            },
                          ),

                          const SizedBox(height: 36),

                          /// DATE + TIME
                          Row(
                            children: [
                              Expanded(
                                child: InfoCard(
                                  title: "deadline",
                                  icon: Icons.calendar_today,
                                  value: formatDate(
                                    selectedDate,
                                  ),
                                  onTap: pickDate,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: InfoCard(
                                  title: "time",
                                  icon: Icons.schedule,
                                  value: selectedTime.format(
                                    context,
                                  ),
                                  onTap: pickTime,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 36),

                          /// MOODBOARD
                          const MoodboardCard(),

                          const SizedBox(height: 140),
                        ],
                      ),
                    ),
                  ),

                  /// BUTTON
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      bottom: 30,
                      top: 10,
                    ),
                    child: CuratorButton(
                      text: widget.isEdit
                          ? "edit your changes"
                          : "commit to grid",
                      icon: Icons.bolt,
                      onTap: () {
                        /// CREATE TASK
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
