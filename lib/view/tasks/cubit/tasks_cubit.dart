import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/repositories/tasks_repo/remote_tasks_repo.dart';

import '../../../models/tasks_model.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit({required this.remoteTasksRepo}) : super(TasksInitial());
  final RemoteTasksRepo remoteTasksRepo;

  static TasksCubit get(context) => BlocProvider.of(context);







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

  Future<void> getRemoteTasks({
    bool isFirstTime = true,
    required num? userId,
  }) async {
    // to prevent getting tasks if the userId is null
    if (userId==null) return;

    // to prevent multiple requests
    if (gettingMoreTasks) return;

    // if it's the first time, reset the model and pagination
    if (isFirstTime) {
      tasksModel = null;
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
      userId: userId,
      limit: limit,
      skip: skip,
    );
    // handle the result
    result.fold((failure) {

      // if there's an error, set the gettingMoreTasks to false and emit the failure state
      gettingMoreTasks = false;
      emit(GetTasksFailureState(message: failure.message));
    }, (data) {
      // if the data is fetched successfully, add the data to the model
      if (isFirstTime) {
        // if it's the first time, set the model to the fetched data
        tasksModel = data;
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
