import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_router/routes.dart';
import '../../../../core/constants.dart';
import '../../../core/styles/text_styles.dart';
import '../../core/styles/app_colors.dart';
import '../../generated/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    initNavigateToHomeView();
  }

  void initNavigateToHomeView() {
    Future.delayed(const Duration(seconds: 3), () async {

      if (await checkIsFirstTime()) {
        GoRouter.of(context).go(AppRouter.onBoardingScreen);
      } else {
        if (isLoggedIn) {
          GoRouter.of(context).go(AppRouter.appLayout);
        } else {
          GoRouter.of(context).go(AppRouter.loginScreen);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                    height: 200.h,
                    width: 200.h,
                    child: Image.asset(Assets.logoLogo)),
              )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Developed By ',
                          style: MyTextStyles.textStyle16Bold),
                      TextSpan(
                          text: 'Attia Fouad',
                          style: MyTextStyles.textStyle16Bold
                              .copyWith(color: AppColors.greyTextColor)),
                    ])),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
