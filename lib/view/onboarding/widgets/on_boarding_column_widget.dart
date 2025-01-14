import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:task_manager_app/core/constants.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/styles/text_styles.dart';

class OnBoardingColumn extends StatelessWidget {
  final String title;
  final String desc;

  const OnBoardingColumn({required this.title, required this.desc, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(350.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: appPadding),
          child: Column(
            children: [
              const Gap(20),
              Text(
                title,
                style: MyTextStyles.textStyle22Bold.copyWith(
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
               Gap(20.h),
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
