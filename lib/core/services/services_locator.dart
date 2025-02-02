import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager_app/core/networks/remote/dio_helper.dart';
import 'package:task_manager_app/view/tasks/cubit/tasks_cubit.dart';

import '../../repositories/auth_repo/auth_repo.dart';
import '../../repositories/auth_repo/auth_repo_impl.dart';
import '../../repositories/tasks_repo/local_tasks_repo.dart';
import '../../repositories/tasks_repo/local_tasks_repo_impl.dart';
import '../../repositories/tasks_repo/remote_tasks_repo.dart';
import '../../repositories/tasks_repo/remote_tasks_repo_impl.dart';
import '../../view/app_layout/cubit/app_cubit.dart';
import '../../view/login/cubit/login_cubit.dart';
import '../constants.dart';
import '../networks/local/cache_helper.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    // cubits
    sl.registerFactory(() => AppCubit(authRepo: sl<AuthRepo>(),cacheHelper: sl<CacheHelper>()));
    sl.registerFactory(() => LoginCubit(
          authRepo: sl<AuthRepo>(),
        ));
    sl.registerFactory(() => TasksCubit(
          remoteTasksRepo: sl<RemoteTasksRepo>(),
      localTasksRepo: sl<LocalTasksRepo>(),
        ));

    //Repository
    sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(dioHelper: sl<DioHelper>()));
    sl.registerLazySingleton<RemoteTasksRepo>(() => RemoteTasksRepoImpl(dioHelper: sl<DioHelper>()));
    sl.registerLazySingleton<LocalTasksRepo>(
        () => LocalTasksRepoImpl(db: sl<Database>()));


    // dependencies
    sl.registerLazySingleton<DioHelper>(() => DioHelper());
    sl.registerLazySingleton<CacheHelper>(() => CacheHelper());
    sl.registerLazySingleton<Database>(() => database);
  }
}
