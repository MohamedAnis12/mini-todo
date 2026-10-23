import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minitodo/database/database_helper.dart';
import 'package:minitodo/models/task_model.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  int filterNumber=0;
List<TaskModel> allTasks = [];
  Future<void> addNewTask(TaskModel task) async {
    emit(TaskLoading());
    try {
      await DatabaseHelper.insertTask(task);
      final tasks = await DatabaseHelper.getTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> getTasks() async {
    emit(TaskLoading());
    try {
      final tasks = await DatabaseHelper.getTasks();
      allTasks=tasks;
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> updateTask(TaskModel task) async {
    emit(TaskLoading());
    try {
      await DatabaseHelper.updateTask(task);
      final tasks = await DatabaseHelper.getTasks();

      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> deleteTask(TaskModel task) async {
    emit(TaskLoading());
    try {
      await DatabaseHelper.deleteTask(task.id!);
      final tasks = await DatabaseHelper.getTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  void filterTasks( int filter) {
    filterNumber=filter;
    emit(TaskLoading());
    try {
      if (filter == 0) {
        emit(TaskLoaded(allTasks));
      } else if (filter == 1) {
        emit(TaskLoaded(allTasks.where((task) => task.isDone).toList()));
      } else {
        emit(TaskLoaded(allTasks.where((task) => !task.isDone).toList()));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
