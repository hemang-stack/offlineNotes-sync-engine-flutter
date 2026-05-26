import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_theme.dart';
import 'package:frontend/features/tasks/models/task_model.dart';
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
  late List<TaskModel> _tasks;
  int _completedTasks = 0;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _initializeTasks();
  }

  void _initializeTasks() {
    _tasks = [
      TaskModel(
        id: '1',
        title: 'Review Design Specs',
        priority: TaskPriority.high,
        status: TaskStatus.pending,
        startTime: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          10,
          0,
        ),
        endTime: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          11,
          0,
        ),
        category: 'Design',
        isCompleted: false,
      ),
      TaskModel(
        id: '2',
        title: 'Product Sync',
        priority: TaskPriority.medium,
        status: TaskStatus.pending,
        startTime: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          13,
          0,
        ),
        endTime: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          14,
          0,
        ),
        category: 'Sync',
        isCompleted: false,
      ),
      TaskModel(
        id: '3',
        title: 'Q4 Roadmap Planning',
        priority: TaskPriority.high,
        status: TaskStatus.pending,
        startTime: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          15,
          30,
        ),
        endTime: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          17,
          0,
        ),
        category: 'Strategy',
        isCompleted: false,
      ),
      TaskModel(
        id: '4',
        title: 'App completion before 31st May',
        priority: TaskPriority.medium,
        status: TaskStatus.pending,
        startTime: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          13,
          0,
        ),
        endTime: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          14,
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

  void _onPreviousMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1);
    });
  }

  void _onNextMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1);
    });
  }

  void _onTaskChecked(TaskModel task) {
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add task feature coming soon!'),
        duration: Duration(seconds: 2),
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
