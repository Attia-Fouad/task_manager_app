import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/core/styles/app_colors.dart';
import 'package:task_manager_app/core/styles/text_styles.dart';

import '../view/reusable_widgets/default_button.dart';
import '../view/reusable_widgets/designed_form_field.dart';
import 'app_strings/app_strings.dart';

void showToast({
  String? text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { ERROR, SUCCESS, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = AppColors.primaryColor;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}



void showAddTaskDialog(
    BuildContext context, Function(String taskDetails) onAdd) {
  final TextEditingController taskController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(
          child: Text(
            AppStrings.addNewTask,
            style: MyTextStyles.textStyle18Bold,
          ),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DesignedFormField(
                controller: taskController,
                allowMultiLines: true,
                minLines: 3,
                hintText: AppStrings.details,
                validator: (String? val) {
                  if (val == null || val.isEmpty) {
                    return AppStrings.pleaseEnterTaskDetails;
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: DefaultButton(
                  color: const Color(0xffE0E0E0),
                  text: AppStrings.cancel,
                  textStyle: MyTextStyles.textStyle16Bold.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  onTap: () {
                    GoRouter.of(context).pop();
                  },
                ),
              ),
              const Gap(10),
              Expanded(
                child: DefaultButton(
                  text: AppStrings.add,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      onAdd(taskController.text);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}