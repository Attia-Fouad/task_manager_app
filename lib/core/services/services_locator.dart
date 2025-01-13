import 'package:get_it/get_it.dart';

import '../../repositories/auth_repo/auth_repo.dart';
import '../../repositories/auth_repo/auth_repo_impl.dart';
import '../../view/app_layout/cubit/app_cubit.dart';
import '../../view/login/cubit/login_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    // cubits
    sl.registerFactory(() => AppCubit());

    sl.registerFactory(() => LoginCubit(
          authRepo: sl<AuthRepo>(),
        ));

    //Repository
    sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());
  }
}
