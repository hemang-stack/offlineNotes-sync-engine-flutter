part of 'add_new_task_cubit.dart';

sealed class AddNewTaskState {
  const AddNewTaskState();
}

final class AddNewTaskInitial extends AddNewTaskState {
  const AddNewTaskInitial();
}

final class AddNewTaskLoading extends AddNewTaskState {
  const AddNewTaskLoading();
}

final class AddNewTaskError extends AddNewTaskState {
  final String error;

  const AddNewTaskError(this.error);
}

final class AddNewTaskSuccess extends AddNewTaskState {
  final TaskModel taskModel;

  const AddNewTaskSuccess(this.taskModel);
}