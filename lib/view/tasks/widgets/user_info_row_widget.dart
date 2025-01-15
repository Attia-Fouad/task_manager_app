import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/styles/text_styles.dart';
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
        Text(
          "${cubit.userData!.firstName} ${cubit.userData!.lastName}",
          style: MyTextStyles.textStyle18Bold,
        ),
      ],
    );
  }
}
