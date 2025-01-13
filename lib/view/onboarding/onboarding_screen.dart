import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../core/app_router/routes.dart';
import '../../core/app_strings/app_strings.dart';
import '../../core/networks/local/cache_helper.dart';
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
    return  OnBoardingSlider(
      indicatorAbove: true,
      centerBackground: true,
      finishButtonText: AppStrings.getStarted,
      finishButtonTextStyle:
      MyTextStyles.textStyle18Medium.copyWith(color: Colors.white),
      onFinish: () {
        CacheHelper.saveData(key: 'isFirstTime', value: true);
        GoRouter.of(context).go(AppRouter.appLayout);
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
          child: Center(child:Lottie.asset(Assets.animationsTodo)),
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

class OnBoardingColumn extends StatelessWidget {
  final String title;
  final String desc;

  const OnBoardingColumn({required this.title, required this.desc, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 350.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p28),
          child: Column(
            children: [
              const Gap(20),
              Text(
                title,
                style: MyTextStyles.textStyle22Bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: AppHeight.p20,
              ),
              Text(
                desc,
                style: MyTextStyles.textStyle16Medium,
                textAlign: TextAlign.center,

              ),
            ],
          ),
        ),
      ],
    );
  }
}
