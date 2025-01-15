import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../generated/assets.dart';
import '../../../reusable_widgets/base_card_widget.dart';
import '../../../reusable_widgets/read_more_widget.dart';


class TaskMobileItemWidget extends StatelessWidget {
  const TaskMobileItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: BaseCardWidget(
        child: Row(
          children: [
            IconButton(onPressed: () {},
                icon: const Icon(Icons.circle_outlined,
                  color: AppColors.greyColor,)),
            const Expanded(child: ReadMoreWidget(
              text: "asdasjdklasdjlaksdlkassdfdsfsdjhfdskjfhdskjfhdsjkfhdskjfhdskjfhdksjfhdksjfhkdjshfkjdsfhkjsdhfkjsdhfkdsjfhsdkjfhksdjhfkdjshfksdjhfdksjhfsdkjhdjklasjdlkasjdsalkj",
            )),
            IconButton(onPressed: (){}, icon: SvgPicture.asset(Assets.svgsTrash)),
          ],
        ),
      ),
    );
  }
}
