import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:task_manager_app/core/values_manager.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/shared_components.dart';
import '../../core/app_strings/app_strings.dart';
import '../../core/constants.dart';
import '../../core/styles/text_styles.dart';
import '../../generated/assets.dart';
import '../reusable_widgets/default_button.dart';
import '../reusable_widgets/designed_form_field.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<LoginCubit>(),
        child: Builder(builder: (context) {
          LoginCubit cubit = LoginCubit.get(context);
          return BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) async {
              if (state is LoginFailureState) {
                showToast(state: ToastStates.ERROR, text: state.message);
              }
            },
            builder: (context, state) {
              return Form(
                key: cubit.formKey,
                child:  Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: appPadding),
                    child: Container(
                      // add max width to make the design adaptive
                      constraints: const BoxConstraints(
                        maxWidth: 550,
                      ),
                      child: CustomScrollView(
                        slivers: [
                          const SliverGap(100),
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Gap(5),
                                // welcome back text
                                Text(
                                  AppStrings.welcomeBack,
                                  style: MyTextStyles.textStyle22Bold,
                                ),
                                const Gap(20),
                                SvgPicture.asset(Assets.svgsCheckListSvg),
                                const Gap(50),
                                //username field
                                DesignedFormField(
                                  hintText: AppStrings.userName,
                                  controller: userNameController,
                                  type: TextInputType.text,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.pleaseEnterYourUserName;
                                    }
                                  },
                                ),
                                const Gap(10),
                                //password field
                                DesignedFormField(
                                  hintText: AppStrings.password,
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  isPassword: cubit.isPassword,
                                  suffixIcon: Icon(
                                    cubit.suffix,
                                    size: 20,
                                    color: Colors.grey.shade600,
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.pleaseEnterYourPassword;
                                    }
                                  },
                                  function: () {
                                    cubit.changePasswordVisibility();
                                  },
                                ),
                                const Gap(50),
                                // login button
                                DefaultButton(
                                  loadingController: state is LoginLoadingState,
                                  text: AppStrings.login,
                                  onTap: () {
                                    if (cubit.formKey.currentState!.validate()) {
                                      cubit.login(
                                          username: userNameController.text,
                                          password: passwordController.text
                                      );
                                    }
                                  },
                                ),
                                const Gap(50),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
