import 'package:flutter/material.dart';
import '../../core/styles/app_colors.dart';

class AddFloatingActionButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Color? color;

  const AddFloatingActionButtonWidget({
    super.key,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: onPressed,
      backgroundColor: color ?? AppColors.primaryColor,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
