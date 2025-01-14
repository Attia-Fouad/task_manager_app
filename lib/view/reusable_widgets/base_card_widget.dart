import 'package:flutter/material.dart';

import '../../core/styles/app_colors.dart';

class BaseCardWidget extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final double? padding;
  final double? borderRadius;
  const BaseCardWidget({
    super.key,
    this.child,
    this.color,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 15),
        color: color ?? AppColors.containerBackGroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(padding ?? 12.0),
        child: child,
      ),
    );
  }
}
