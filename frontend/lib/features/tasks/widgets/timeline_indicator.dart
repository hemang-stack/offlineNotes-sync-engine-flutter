import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';

class TimelineIndicator extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isActive;
  final bool isCompleted;

  const TimelineIndicator({
    Key? key,
    this.isFirst = false,
    this.isLast = false,
    this.isActive = false,
    this.isCompleted = false,
  }) : super(key: key);

  Color _getIndicatorColor() {
    if (isCompleted) return AppColors.timelineActive;
    if (isActive) return AppColors.timelineActive;
    return AppColors.timelinePending;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.only(left: 20),
      child: Column(
        children: [
          if (!isFirst)
            Container(
              width: 2,
              height: 12,
              color: _getIndicatorColor(),
            ),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getIndicatorColor(),
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: _getIndicatorColor().withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          if (!isLast)
            Container(
              width: 2,
              height: 80,
              color: isActive ? AppColors.timelineActive : AppColors.timelinePending,
            ),
        ],
      ),
    );
  }
}
