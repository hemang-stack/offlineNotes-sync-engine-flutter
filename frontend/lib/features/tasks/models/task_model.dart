enum TaskPriority {
  high('High'),
  medium('Medium'),
  low('Low');

  final String label;
  const TaskPriority(this.label);
}

enum TaskStatus {
  pending('Pending'),
  inProgress('In Progress'),
  completed('Completed');

  final String label;
  const TaskStatus(this.label);
}

class TaskModel {
  final String id;
  final String title;
  final String? description;
  final TaskPriority priority;
  final TaskStatus status;
  final DateTime startTime;
  final DateTime endTime;
  final String? category;
  final bool isCompleted;
  final DateTime? completedAt;

  const TaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.priority,
    required this.status,
    required this.startTime,
    required this.endTime,
    this.category,
    this.isCompleted = false,
    this.completedAt,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    TaskPriority? priority,
    TaskStatus? status,
    DateTime? startTime,
    DateTime? endTime,
    String? category,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Duration get duration => endTime.difference(startTime);

  String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String get formattedStartTime => formatTime(startTime);

  String get formattedEndTime => formatTime(endTime);

  String get timeRange => '$formattedStartTime - $formattedEndTime';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          priority == other.priority &&
          status == other.status;

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ priority.hashCode ^ status.hashCode;
}
