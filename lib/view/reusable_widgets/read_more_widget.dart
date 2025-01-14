import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../core/app_strings/app_strings.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/text_styles.dart';

class ReadMoreWidget extends StatelessWidget {
  const ReadMoreWidget({
    super.key,
    required this.text,
    this.moreText,
    this.lessText,
    this.style,
    this.moreStyle,
    this.lessStyle,
  });

  final String text;
  final String? moreText;
  final String? lessText;
  final TextStyle? style;
  final TextStyle? moreStyle;
  final TextStyle? lessStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ReadMoreText(
        text,
        trimMode: TrimMode.Line,
        trimLines: 2,
        trimCollapsedText: moreText ?? AppStrings.showMore,
        trimExpandedText: lessText ?? AppStrings.showLess,
        style: style ?? MyTextStyles.textStyle12Medium,
        moreStyle: moreStyle ??
            MyTextStyles.textStyle12Bold.copyWith(
              color: AppColors.primaryColor,
            ),
        lessStyle: lessStyle ??
            MyTextStyles.textStyle12Bold.copyWith(
              color: AppColors.primaryColor,
            ),
      ),
    );
  }
}
