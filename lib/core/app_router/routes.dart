import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/core/app_router/pages_animations.dart';
import '../../view/app_layout/app_layout.dart';
import '../../view/login/login_screen.dart';
import '../../view/onboarding/onboarding_screen.dart';
import '../../view/splash/splash_screen.dart';
import '../../view/tasks/tasks_screen.dart';
import 'animation_type.dart';

abstract class AppRouter {
  static const splashScreen = '/';
  static const onBoardingScreen = '/onBoardingScreen';
  static const appLayout = '/appLayout';
  static const loginScreen = '/loginScreen';
  static const tasksScreen = '/tasksScreen';

  static final router = GoRouter(
    routes: [
      // splashScreen
      GoRoute(
        path: splashScreen,
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const SplashScreen(),
          animationType: AnimationType.fadeTransitionAnimation,
        ),
      ),
      // onboardingScreen
      GoRoute(
        path: onBoardingScreen,
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const OnBoardingScreen(),
          animationType: AnimationType.fadeTransitionAnimation,
        ),
      ),
      //appLayout
      GoRoute(
        path: appLayout,
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const AppLayoutScreen(),
          animationType: AnimationType.fadeTransitionAnimation,
        ),
      ),

      //LoginScreen
      GoRoute(
        path: loginScreen,
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const LoginScreen(),
          animationType: AnimationType.fadeTransitionAnimation,
        ),
      ),
      //TasksScreen
      GoRoute(
        path: tasksScreen,
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const TasksScreen(),
          animationType: AnimationType.fadeTransitionAnimation,
        ),
      ),
    ],
  );
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  required AnimationType animationType,
}) {
  return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (animationType) {
          case AnimationType.fadeTransitionAnimation:
            return fadeTransition(animation: animation, child: child);
          case AnimationType.sideTransitionFromDownToUp:
            return sideTransitionFromDownToUp(
                animation: animation, child: child);
          case AnimationType.sideTransitionFromLtoR:
            return sideTransitionFromLtoR(child: child, animation: animation);
          case AnimationType.sideTransitionFromRtoL:
            return sideTransitionFromRtoL(child: child, animation: animation);
          case AnimationType.sideTransitionFromUpToDown:
            return sideTransitionFromUpToDown(
                child: child, animation: animation);
          case AnimationType.sideTransitionFromDownToUpWithFadeTransition:
            return sideTransitionFromDownToUpWithFadeTransition(
                child: child, animation: animation);
          default:
            return fadeTransition(animation: animation, child: child);
        }
      });
}
