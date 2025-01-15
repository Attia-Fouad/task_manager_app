import 'package:flutter/material.dart';

import '../../../core/app_strings/app_strings.dart';
import '../../../generated/assets.dart';
import '../../reusable_widgets/svg_image_with_text_widget.dart';

class NoTasksWidget extends StatelessWidget {
  const NoTasksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: SvgImageWithTextWidget(
        text: AppStrings.dontHaveToDoYet,
        svgImage: Assets.svgsEmptyListSvg,
      ),
    );
  }
}
