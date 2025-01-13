import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/shared_components.dart';
import '../../core/constants.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<LoginCubit>(),
        child: Builder(builder: (context) {
          var cubit = LoginCubit.get(context);
          return BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) async {
              if (state is LoginFailureState) {
                showToast(state: ToastStates.ERROR, text: state.message);
              }
            },
            builder: (context, state) {
              return Form(
                key: cubit.formKey,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: appPadding),
                  child: CustomScrollView(
                    slivers: [
                      // SliverFillRemaining(
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       HeadlineText(text: AppStrings.welcome.tr(context)),
                      //
                      //       const Gap(5),
                      //       Text(
                      //         AppStrings.enterYourEmailToSignIn.tr(context),
                      //         style: MyTextStyles.textStyle16Regular.copyWith(color: AppColors.greyTextColor),
                      //       ),
                      //       const Gap(50),
                      //       //email field
                      //       DesignedFormField(
                      //         hintText: AppStrings.enterYourEmail.tr(context),
                      //         controller: cubit.signInEmailController,
                      //         type: TextInputType.emailAddress,
                      //         validator: (String? value) {
                      //           if (value!.isEmpty) {
                      //             return AppStrings.pleaseEnterYourEmail.tr(context);
                      //           }
                      //         },
                      //       ),
                      //       const Gap(10),
                      //       //password field
                      //       DesignedFormField(
                      //         hintText: AppStrings.enterYourPassword.tr(context),
                      //         controller: cubit.signInPasswordController,
                      //         type: TextInputType.visiblePassword,
                      //         textInputAction: TextInputAction.done,
                      //         isPassword: cubit.isPassword,
                      //         onChange: (String? value) {
                      //           cubit.setState();
                      //         },
                      //         suffixIcon: Icon(
                      //           cubit.suffix,
                      //           size: 20,
                      //           color: Colors.grey.shade600,
                      //         ),
                      //         validator: (String? value) {
                      //           if (value!.isEmpty) {
                      //             return AppStrings.pleaseEnterYourPassword.tr(context);
                      //           }
                      //         },
                      //         function: () {
                      //           cubit.changePasswordVisibility();
                      //         },
                      //       ),
                      //       const Gap(10),
                      //       DesignedFormField(
                      //         hintText: AppStrings.type.tr(context),
                      //         readOnly: true,
                      //         isBottomSheet: true,
                      //         controller: cubit.typeController,
                      //         onTap: () {
                      //           showDefaultBottomSheet(
                      //             height: 250.h,
                      //             context: context,
                      //             text: AppStrings.selectType.tr(context),
                      //             buttonOnTap: () {
                      //               Navigator.of(context).pop();
                      //             },
                      //             child: TypeBottomSheetChild(
                      //               selectedType: cubit.selectedType,
                      //               onChanged: (value) {
                      //                 cubit.selectedType = value!;
                      //                 if (value == AppStrings.user) {
                      //                   cubit.isSeller = false;
                      //                 } else {
                      //                   cubit.isSeller = true;
                      //                 }
                      //                 cubit.typeController.text = value!.tr(context);
                      //
                      //                 cubit.setState();
                      //                 Navigator.pop(context);
                      //               },
                      //             ),
                      //           );
                      //         },
                      //         suffixIcon: Image.asset(Assets.imagesArrowUp),
                      //         validator: (String? val) {
                      //           if (val!.isEmpty) {
                      //             return AppStrings.pleaseSelectType.tr(context);
                      //           }
                      //         },
                      //       ),
                      //
                      //       const Gap(10),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.end,
                      //         children: [
                      //           // Expanded(
                      //           //   child: ReusableCheckBox(
                      //           //       title: AppStrings.seller.tr(context),
                      //           //       controller: cubit.isSeller,
                      //           //       onChanged: (val) {
                      //           //         cubit.isSeller = val;
                      //           //         cubit.setState();
                      //           //       }),
                      //           // ),
                      //
                      //           InkWell(
                      //             onTap: () {
                      //               GoRouter.of(context).push(AppRouter.forgotPasswordScreen);
                      //             },
                      //             child: Text(
                      //               AppStrings.forgotYourPassword.tr(context),
                      //               style: MyTextStyles.textStyle12Medium.copyWith(
                      //                 color: AppColors.primaryColor,
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       const Spacer(),
                      //       DefaultButton(
                      //         loadingController: state is LoginLoadingState,
                      //         text: AppStrings.login.tr(context),
                      //         onTap: () {
                      //           if (cubit.formKey.currentState!.validate()) {
                      //             cubit.login(email: cubit.signInEmailController.text, password: cubit.signInPasswordController.text);
                      //           }
                      //         },
                      //       ),
                      //       const Gap(20),
                      //       Center(
                      //           child: Text(
                      //         AppStrings.or.tr(context),
                      //         style: MyTextStyles.textStyle14Regular,
                      //       )),
                      //       const Gap(20),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             AppStrings.newMember.tr(context),
                      //             style: MyTextStyles.textStyle14Regular,
                      //           ),
                      //           const Gap(5),
                      //           InkWell(
                      //             onTap: () {
                      //               GoRouter.of(context).push(AppRouter.registerScreen);
                      //             },
                      //             child: Text(
                      //               AppStrings.signUp.tr(context),
                      //               style: MyTextStyles.textStyle14Medium.copyWith(
                      //                 color: AppColors.primaryColor,
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       const Gap(20),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           InkWell(
                      //             onTap: () {
                      //               cubit.loginWithGoogle();
                      //             },
                      //             child: SvgPicture.asset(
                      //               Assets.svgGoogle,
                      //               width: 40,
                      //               height: 40,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       const Gap(50),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
