import 'package:flutter/material.dart';
import 'package:hiring_task/constants/colors/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.beat(
        color: AppColors.primaryColor,
        size: 50,
      ),
    );
  }
}
