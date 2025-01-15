import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/repositories/tasks_repo/remote_tasks_repo.dart';

import '../../../models/tasks_model.dart';
import '../../../repositories/tasks_repo/local_tasks_repo.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit({
    required this.remoteTasksRepo,
    required this.localTasksRepo,
  }) : super(TasksInitial());
  final RemoteTasksRepo remoteTasksRepo;
  final LocalTasksRepo localTasksRepo;

  static TasksCubit get(context) => BlocProvider.of(context);

  //______________________________________________ local operations
  saveTasksLocally(List<TaskModel> tasks) async {
    await localTasksRepo.insertTasks(tasks);
  }

  deleteStoredLocalTasks() async {
    await localTasksRepo.deleteAllTasks();
  }

  getStoredLocalTasks() async {
    var cachedTasks = await localTasksRepo.getTasks();
    tasksModel = TasksModel(
        todos: cachedTasks,
        total: cachedTasks.length,
        skip: skip,
        limit: limit);
    emit(GetTasksSuccessState());
  }

  //______________________________________________ remote operations

  addNewTask({required String taskTitle, required num userId}) async {
    emit(AddNewTaskLoadingState());
    var result =
        await remoteTasksRepo.addNewTasks(userId: userId, taskTitle: taskTitle);
    result.fold((l) {
      emit(AddNewTaskFailureState(message: l.message));
    }, (r) {
      tasksModel?.todos.add(r);
      emit(AddNewTaskSuccessState());
    });
  }

  editTask({required TaskModel task}) async {
    // change the task status to the opposite
    task.completed = !task.completed;
    emit(EditTaskLoadingState());
    var result = await remoteTasksRepo.updateTasks(task: task);
    result.fold((l) {
      // rollback the changes if it  failed
      task.completed = !task.completed;
      emit(EditTaskFailureState(message: l.message));
    }, (r) {
      emit(EditTaskSuccessState());
    });
  }

  deleteTask({required TaskModel task}) async {
    // change the task status to the opposite
    emit(EditTaskLoadingState());
    var result = await remoteTasksRepo.deleteTasks(task: task);
    result.fold((l) {
      emit(EditTaskFailureState(message: l.message));
    }, (r) {
      tasksModel!.todos.remove(task);
      emit(EditTaskSuccessState());
    });
  }

  //______________________________________________________________________________
  // for scrolling pagination
  var scrollController = ScrollController();

  void startScrollingListener({required num userId}) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.8 &&
          tasksModel != null) {
        getRemoteTasks(isFirstTime: false, userId: userId);
      }
    });
  }

  TasksModel? tasksModel;

  int skip = 0;
  int limit = 15;
  bool gettingMoreTasks = false;

  getRemoteTasks({
    bool isFirstTime = true,
    required num? userId,
  }) async {

    // to prevent getting tasks if the userId is null
    if (userId==null) return;
    // to prevent multiple requests
    if (gettingMoreTasks) return;

    // if it's the first time, reset the model and pagination
    if (isFirstTime) {
      tasksModel=null;
      skip = 0;
    }

    // if it's not the first time and the skip * limit is greater than the total tasks, return
    if (!isFirstTime && (skip * limit) > tasksModel!.total) {
      return;
    }
    // set the gettingMoreTasks to true to prevent multiple requests
    gettingMoreTasks = true;
    emit(GetTasksLoadingState());

    // get the tasks
    var result = await remoteTasksRepo.getAllUserTasks(
      userId: userId??-1,
      limit: limit,
      skip: skip,
    );
    // handle the result
    result.fold((failure) {
      // if there's an error, set the gettingMoreTasks to false and emit the failure state
      gettingMoreTasks = false;
      emit(GetTasksFailureState(message: failure.message));
      // if there's an error, try to get the tasks from the local storage
      getStoredLocalTasks();
    }, (data) async {
      // if the data is fetched successfully, add the data to the model
      if (isFirstTime) {
        // if it's the first time, set the model to the fetched data
        tasksModel = data;
        // when get new data from the server, delete the local tasks
        await deleteStoredLocalTasks();
        // save the new data to the local storage
        saveTasksLocally(tasksModel!.todos);
      } else {
        // if it's not the first time, add the fetched data to the existing model
        tasksModel?.todos.addAll(data.todos);
      }
      // increment the skip
      skip++;
      // set the gettingMoreTasks to false
      gettingMoreTasks = false;
      // emit the success state
      emit(GetTasksSuccessState());
    });
  }
}
