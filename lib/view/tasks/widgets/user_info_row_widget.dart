import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/core/constants.dart';

import '../../../core/app_router/routes.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../generated/assets.dart';
import '../../app_layout/cubit/app_cubit.dart';
import '../../reusable_widgets/circular_image_widget.dart';

class UserInfoRowWidget extends StatelessWidget {
  const UserInfoRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return Row(
      children: [
        CircularImageWidget(
          image: cubit.userData!.image,
        ),
        const Gap(10),
        Expanded(
          child: Text(
            "${cubit.userData!.firstName} ${cubit.userData!.lastName}",
            style: MyTextStyles.textStyle18Bold,
          ),
        ),
        const Gap(10),
        InkWell(onTap: () {
          removeToken();
          removeRefreshToken();
          GoRouter.of(context).go(AppRouter.loginScreen);
        }, child: SvgPicture.asset(Assets.svgsLogout,
        color: AppColors.primaryColor,))
      ],
    );
  }
}
