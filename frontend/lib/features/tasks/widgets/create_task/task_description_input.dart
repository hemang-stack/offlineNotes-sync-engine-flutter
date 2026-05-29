import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class TaskDescriptionInput extends StatelessWidget {
  final TextEditingController descriptionController;

  const TaskDescriptionInput({
    super.key,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: descriptionController,
      minLines: 2,
      maxLines: 4,
      cursorColor: AppColors.primary,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 13,
        height: 1.8,
      ),
      decoration: InputDecoration(
        hintText: "add context, notes, goals or details...",
        hintStyle: TextStyle(
            color: Colors.white.withOpacity(.18),
            fontSize: 16,
            height: 0.75,
            fontWeight: FontWeight.bold),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        filled: false,
        contentPadding: EdgeInsets.zero,
        isDense: true,
        isCollapsed: true,
      ),
    );
  }
}
