import 'package:flutter/material.dart';
import 'date_item.dart';

class DateTimeline extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final int daysInMonth;

  const DateTimeline({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.daysInMonth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: daysInMonth,
        itemBuilder: (context, index) {
          final day = index + 1;
          final date = DateTime(
            selectedDate.year,
            selectedDate.month,
            day,
          );
          final isSelected = day == selectedDate.day;

          return DateItem(
            day: day,
            dayOfWeek: _getDayOfWeek(date),
            isSelected: isSelected,
            onTap: () => onDateSelected(date),
          );
        },
      ),
    );
  }

  String _getDayOfWeek(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final weekday = date.weekday;
    return days[weekday - 1];
  }
}
