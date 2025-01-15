import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/view/tasks/widgets/user_info_row_shimmer.dart';
import 'package:task_manager_app/view/tasks/widgets/user_info_row_widget.dart';

import '../../app_layout/cubit/app_cubit.dart';

class UserDataSection extends StatelessWidget {
  const UserDataSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          return AppCubit.get(context).userData == null
              ? const UserInfoRowShimmer()
              : const UserInfoRowWidget();
        },
      ),
    );
  }
}
