import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../core/styles/text_styles.dart';

class SvgImageWithTextWidget extends StatelessWidget {
  const SvgImageWithTextWidget({
    super.key,
    required this.svgImage,
    this.text,
    this.widget,
  });

  final String svgImage;
  final String? text;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(svgImage),
          const Gap(20),
          if (text != null)
            Text(
              text!,
              style: MyTextStyles.textStyle16Medium,
            ),
          if (widget != null) widget!,
        ],
      ),
    );
  }
}
