import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager_app/view/app_layout/cubit/app_cubit.dart';

import 'core/app_router/routes.dart';
import 'core/bloc_helper/my_bloc_observer.dart';
import 'core/constants.dart';
import 'core/networks/local/cache_helper.dart';
import 'core/networks/local/secure_cache_helper.dart';
import 'core/networks/remote/dio_helper.dart';
import 'core/services/services_locator.dart';
import 'core/styles/themes.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize dio helper
  DioHelper.init();
  // initialize Cache Helper
  CacheHelper.init();
  // initialize Services Locator
  ServicesLocator().init();
  // initialize locObserver
  Bloc.observer = MyBlocObserver();
  // Use Future.wait to wait for all the futures to complete
  await Future.wait(futures);
  runApp(


      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(), // Wrap your app
      ),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AppCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(
          375,
          812,
        ),
        builder: (context, child) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
          );
        },
      ),
    );
  }
}

List<Future<void>> futures = [
  SecureCacheHelper.init(),
  checkLoginStatus(),
];