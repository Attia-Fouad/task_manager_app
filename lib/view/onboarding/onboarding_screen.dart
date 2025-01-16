import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/view/onboarding/widgets/on_boarding_column_widget.dart';
import '../../core/app_router/routes.dart';
import '../../core/app_strings/app_strings.dart';
import '../../core/constants.dart';
import '../../core/networks/local/cache_helper.dart';
import '../../core/services/services_locator.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/text_styles.dart';
import '../../core/values_manager.dart';
import '../../generated/assets.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late Material materialButton;
  late int index;

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      indicatorAbove: true,
      centerBackground: true,
      finishButtonText: AppStrings.getStarted,
      finishButtonTextStyle:
          MyTextStyles.textStyle18Medium.copyWith(color: Colors.white),
      onFinish: () {
        // Save the first time to the cache to avoid showing the onboarding screen again
        sl<CacheHelper>().saveData(key: 'isFirstTime', value: true);
        // Check if the user is logged in or not
        if (isLoggedIn) {
          GoRouter.of(context).go(AppRouter.appLayout);
        } else {
          GoRouter.of(context).go(AppRouter.loginScreen);
        }
      },
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      controllerColor: AppColors.primaryColor,
      totalPage: 1,
      headerBackgroundColor: AppColors.backgroundColor,
      pageBackgroundColor: AppColors.backgroundColor,
      background: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p18,
            vertical: AppPadding.p18,
          ),
          child: Center(child: SvgPicture.asset(Assets.svgsOnBoarding)),
        ),
      ],
      speed: 2,
      pageBodies: const [
        OnBoardingColumn(
          title: AppStrings.firstOnboardingTitle,
          desc: AppStrings.firstOnboardingDescription,
        ),
      ],
      hasSkip: false,
    );
  }
}
