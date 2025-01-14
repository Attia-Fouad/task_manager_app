import 'package:flutter/material.dart';

class DefaultLoadingWidget extends StatelessWidget {
  const DefaultLoadingWidget({super.key,  this.size});
  final double? size ;

  @override
  Widget build(BuildContext context) {
    return Center(
      child:  SizedBox(
        height:size?? 30,
        width:size?? 30 ,
        child:const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
