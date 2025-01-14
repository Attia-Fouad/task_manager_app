import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class CircularImageWidget extends StatelessWidget {
  const CircularImageWidget({
    super.key,
    required this.image,
    this.size = 45,
    this.radius,
  });

  final String image;
  final double? size;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xffEEF5FF),
      radius:size!=null? (size!*0.5+1):null,
      child: Container(
        height: size,
        width: size,
        decoration:  BoxDecoration(
          color: const Color(0xffEEF5FF),
          borderRadius:radius!=null? BorderRadius.all(Radius.circular(radius!)):null,
           shape:radius==null? BoxShape.circle:BoxShape. rectangle,
        ),
        clipBehavior: Clip.antiAlias,
        child: FancyShimmerImage(
          imageUrl: image,
          boxFit: BoxFit.cover,
        ),
      ),
    );
  }
}
