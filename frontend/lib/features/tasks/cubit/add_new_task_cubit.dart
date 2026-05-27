import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/tasks/models/task_UI_model.dart';
import 'package:frontend/features/tasks/repository/task_remote_repository.dart';
import 'package:frontend/models/task_model.dart';

part 'add_new_task_state.dart';

class AddNewTaskCubit extends Cubit<AddNewTaskState> {
  AddNewTaskCubit() : super(const AddNewTaskInitial());

  final taskRemoteRepository = TaskRemoteRepository();

  Future<void> createNewTask({
    required String title,
    String? description,
    required TaskPriority priority,
    required DateTime scheduledAt,
    String? category,
    required bool isCompleted,
    required String token,
  }) async {
    try {
      emit(const AddNewTaskLoading());

      final task = await taskRemoteRepository.createTask(
        title: title,
        description: description ?? '',
        dueAt: scheduledAt,
        priority: priority.name,
        category: category ?? '',
        isCompleted: isCompleted,
        token: token,
      );

      emit(AddNewTaskSuccess(task));

    } catch (e) {
      emit(AddNewTaskError(e.toString()));
    }
  }
}