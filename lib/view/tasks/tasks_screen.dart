import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:task_manager_app/core/styles/text_styles.dart';
import 'package:task_manager_app/view/reusable_widgets/add_floating_action_button_widget.dart';
import 'package:task_manager_app/view/reusable_widgets/base_card_widget.dart';
import 'package:task_manager_app/view/tasks/cubit/tasks_cubit.dart';

import '../../core/app_strings/app_strings.dart';
import '../../core/constants.dart';
import '../../core/services/services_locator.dart';
import '../../core/styles/app_colors.dart';
import '../../generated/assets.dart';
import '../reusable_widgets/read_more_widget.dart';
import '../reusable_widgets/svg_image_with_text_widget.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<TasksCubit>(),
        child: Builder(builder: (context) {
          var cubit = TasksCubit.get(context);
          return BlocConsumer<TasksCubit, TasksState>(
            listener: (context, state) {},
            builder: (context, state) {
              return RefreshIndicator(
                color: AppColors.primaryColor,
                backgroundColor: Colors.white,
                onRefresh: () async {
                  // cubit.getRemoteTasks(userId: userId);
                },
                child:  Padding(
                  padding: EdgeInsets.symmetric(horizontal: appPadding),
                  child: CustomScrollView(
                    physics: AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    slivers: [
                      SliverGap(100),
                      SliverFillRemaining(
                        child: SvgImageWithTextWidget(
                          text: AppStrings.dontHaveToDoYet,
                          svgImage: Assets.svgsEmptyListSvg,
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: BaseCardWidget(
                                    child: Row(
                                      children: [
                                        IconButton(onPressed: () {},
                                            icon: const Icon(Icons.circle_outlined,
                                            color: AppColors.greyColor,)),
                                        Expanded(child: ReadMoreWidget(
                                          text: "asdasjdklasdjlaksdlkassdfdsfsdjhfdskjfhdskjfhdsjkfhdskjfhdskjfhdksjfhdksjfhkdjshfkjdsfhkjsdhfkjsdhfkdsjfhsdkjfhksdjhfkdjshfksdjhfdksjhfsdkjhdjklasjdlkasjdsalkj",
                                        )),
                                        IconButton(onPressed: (){}, icon: SvgPicture.asset(Assets.svgsTrash)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: 3
                          )),
                      SliverGap(80),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: AddFloatingActionButtonWidget(
        onPressed: () {},
      ),
    );
  }
}
