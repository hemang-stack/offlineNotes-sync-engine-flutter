import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_theme.dart';
import 'package:frontend/features/home/pages/create_task_page.dart';
import 'package:frontend/features/tasks/models/task_UI_model.dart';
import 'package:frontend/features/tasks/widgets/custom_header.dart';
import 'package:frontend/features/tasks/widgets/date_timeline.dart';
import 'package:frontend/features/tasks/widgets/floating_add_button.dart';
import 'package:frontend/features/tasks/widgets/month_selector.dart';
import 'package:frontend/features/tasks/widgets/task_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime _selectedDate;
  late List<TaskUIModel> _tasks;
  int _completedTasks = 0;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _initializeTasks();
  }

  void _initializeTasks() {
    _tasks = [
      TaskUIModel(
        id: '1',
        title: 'Review Design Specs',
        description:
            'Checking the design specs for the client before the meeting',
        priority: TaskPriority.high,
        scheduledAt: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          10,
          0,
        ),
        category: 'Design',
        isCompleted: false,
      ),
      TaskUIModel(
        id: '2',
        title: 'Product Sync',
        description: 'Checking the designs',
        priority: TaskPriority.medium,
        scheduledAt: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          13,
          0,
        ),
        category: 'Sync',
        isCompleted: false,
      ),
      TaskUIModel(
        id: '3',
        title: 'Q4 Roadmap Planning',
        description: 'Specs for the client before the meeting',
        priority: TaskPriority.high,
        scheduledAt: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          15,
          30,
        ),
        category: 'Strategy',
        isCompleted: false,
      ),
      TaskUIModel(
        id: '4',
        title: 'App completion before 31st May',
        priority: TaskPriority.medium,

        scheduledAt: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          13,
          0,
        ),
        category: 'Sync',
        isCompleted: false,
      ),
    ];
    _updateCompletedTaskCount();
  }

  void _updateCompletedTaskCount() {
    _completedTasks = _tasks.where((task) => task.isCompleted).length;
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  final DateTime _today = DateTime.now();

  void _onPreviousMonth() {
    setState(() {
      final previousMonth = DateTime(
        _selectedDate.year,
        _selectedDate.month - 1,
        1,
      );

      if (previousMonth.month == _today.month &&
          previousMonth.year == _today.year) {
        _selectedDate = _today;
      } else {
        _selectedDate = previousMonth;
      }
    });
  }

  void _onNextMonth() {
    setState(() {
      final nextMonth = DateTime(
        _selectedDate.year,
        _selectedDate.month + 1,
        1,
      );

      if (nextMonth.month == _today.month && nextMonth.year == _today.year) {
        _selectedDate = _today;
      } else {
        _selectedDate = nextMonth;
      }
    });
  }

  void _onTaskChecked(TaskUIModel task) {
    setState(() {
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = _tasks[index].copyWith(
          isCompleted: !_tasks[index].isCompleted,
          completedAt: _tasks[index].isCompleted ? null : DateTime.now(),
        );
        _updateCompletedTaskCount();
      }
    });
  }

  void _onAddTaskTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CreateTaskPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(
      _selectedDate.year,
      _selectedDate.month + 1,
      0,
    ).day;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(
              userName: 'Hulk',
              avatarUrl: null,
              syncStatus: 'Synced · Last synced 2h ago',
              statusColor: AppColors.high,
              onSyncTap: _onAddTaskTap,
            ),
            MonthSelector(
              selectedDate: _selectedDate,
              onPreviousMonth: _onPreviousMonth,
              onNextMonth: _onNextMonth,
            ),
            DateTimeline(
              selectedDate: _selectedDate,
              onDateSelected: _onDateSelected,
              daysInMonth: daysInMonth,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskSection(
                      title: "Today's Schedule",
                      tasks: _tasks,
                      showTimeline: true,
                      onTaskChecked: _onTaskChecked,
                      onTaskTap: (task) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Tapped: ${task.title}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Progress',
                            style: AppTheme.titleLarge.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildProgressCard(
                                label: 'TOTAL',
                                value: _tasks.length.toString(),
                                backgroundColor: AppColors.surfaceVariant,
                              ),
                              _buildProgressCard(
                                label: 'DONE',
                                value: _completedTasks.toString(),
                                backgroundColor: AppColors.badgeHigh,
                                textColor: AppColors.high,
                              ),
                              _buildProgressCard(
                                label: 'LEFT',
                                value: (_tasks.length - _completedTasks)
                                    .toString(),
                                backgroundColor: AppColors.surface,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingAddButton(onPressed: _onAddTaskTap),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildProgressCard({
    required String label,
    required String value,
    required Color backgroundColor,
    Color? textColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: AppTheme.labelSmall.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: AppTheme.headlineMedium.copyWith(
                color: textColor ?? AppColors.textPrimary,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: BottomNavigationBar(
        selectedItemColor: const Color(0xFFFF7A45),
        backgroundColor: AppColors.surface,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_rounded),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_rounded),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tapped item $index'),
              duration: const Duration(milliseconds: 500),
            ),
          );
        },
      ),
    );
  }
}
