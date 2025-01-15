import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../reusable_widgets/default_shimmer.dart';

class UserInfoRowShimmer extends StatelessWidget {
  const UserInfoRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // Circular Image Placeholder
        DefaultShimmer(
          height: 50, // Height and width for circular image
          width: 50,
          radius: 25, // Circular shape
        ),
        Gap(10),
        // Name Placeholder
        DefaultShimmer(
          height: 20,
          width: 120,
          radius: 4,
        ),
      ],
    );
  }
}
