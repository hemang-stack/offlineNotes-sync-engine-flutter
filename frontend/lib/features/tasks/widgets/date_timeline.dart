import 'package:flutter/material.dart';
import 'date_item.dart';

class DateTimeline extends StatefulWidget {
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
  State<DateTimeline> createState() => _DateTimelineState();
}

class _DateTimelineState extends State<DateTimeline> {
  final ScrollController _scrollController = ScrollController();

  static const double itemWidth = 80.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  @override
  void didUpdateWidget(covariant DateTimeline oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedDate.day != widget.selectedDate.day) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelectedDate();
      });
    }
  }

  void _scrollToSelectedDate() {
    if (!_scrollController.hasClients) return;

    final index = widget.selectedDate.day - 1;

    final offset = (index * itemWidth) - 76.5;

    _scrollController.animateTo(
      offset.clamp(
        0,
        _scrollController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: widget.daysInMonth,
        itemBuilder: (context, index) {
          final day = index + 1;

          final date = DateTime(
            widget.selectedDate.year,
            widget.selectedDate.month,
            day,
          );

          final isSelected = day == widget.selectedDate.day;

          return DateItem(
            day: day,
            dayOfWeek: _getDayOfWeek(date),
            isSelected: isSelected,
            onTap: () => widget.onDateSelected(date),
          );
        },
      ),
    );
  }

  String _getDayOfWeek(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }
}