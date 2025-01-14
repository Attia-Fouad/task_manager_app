import 'package:flutter/material.dart';
import 'package:task_manager_app/view/reusable_widgets/default_loading_widget.dart';

import '../../core/styles/app_colors.dart';
import '../../core/styles/text_styles.dart';

class DefaultButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? icon;
  final double? borderRadius;
  final String text;
  final bool borderRadiusTopOnly;
  final bool empty;
  final TextStyle? textStyle;
  final Color? color;
  final double? fontSize;
  final bool upperCase;
  final void Function()? onTap;
  final bool loadingController;
  final double? elevation; // New elevation parameter

  const DefaultButton({
    super.key,
    this.height,
    this.width,
    this.icon,
    this.borderRadius,
    required this.text,
    this.textStyle,
    this.fontSize,
    this.color,
    this.onTap,
    this.borderRadiusTopOnly = false,
    this.loadingController = false,
    this.upperCase = true,
    this.empty = false,
    this.elevation = 0.0, // Default elevation
  });

  @override
  Widget build(BuildContext context) {
    return loadingController
        ? const DefaultLoadingWidget()
        : Center(
            child: Material(
              elevation: elevation ?? 0.0, // Applying elevation
              borderRadius: borderRadiusTopOnly
                  ? BorderRadius.only(
                      topRight: Radius.circular(borderRadius ?? 6),
                      topLeft: Radius.circular(borderRadius ?? 6),
                    )
                  : BorderRadius.circular(borderRadius ?? 15),
              color: Colors
                  .transparent, // Set color to transparent to avoid issues
              child: InkWell(
                onTap: loadingController == false ? onTap : null,
                borderRadius: borderRadiusTopOnly
                    ? BorderRadius.only(
                        topRight: Radius.circular(borderRadius ?? 6),
                        topLeft: Radius.circular(borderRadius ?? 6),
                      )
                    : BorderRadius.circular(borderRadius ?? 15),
                child: Container(
                  height: height,
                  width: width,
                  constraints: const BoxConstraints(
                    minWidth: 145,
                    minHeight: 55,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: empty
                          ? AppColors.primaryColor
                          : (color ?? Colors.white),
                    ),
                    borderRadius: borderRadiusTopOnly
                        ? BorderRadius.only(
                            topRight: Radius.circular(borderRadius ?? 6),
                            topLeft: Radius.circular(borderRadius ?? 6),
                          )
                        : BorderRadius.circular(borderRadius ?? 15),
                    color: empty
                        ? Colors.white
                        : (color ?? AppColors.primaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(text,
                            style: textStyle ??
                                MyTextStyles.textStyle18Bold.copyWith(
                                  color: empty
                                      ? Colors.black
                                      : AppColors.whiteColor,
                                  fontSize: fontSize ?? 18,
                                ),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
