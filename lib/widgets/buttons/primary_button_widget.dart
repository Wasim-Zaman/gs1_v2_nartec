import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hiring_task/constants/colors/app_colors.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String caption;
  final VoidCallback onPressed;
  final double? buttonWidth;
  const PrimaryButtonWidget(
      {Key? key,
      required this.caption,
      required this.onPressed,
      this.buttonWidth})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth ?? context.width * 0.3,
      height: context.height * 0.06,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          caption,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
