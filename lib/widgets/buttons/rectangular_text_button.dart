import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hiring_task/constants/colors/app_colors.dart';

class RectangularTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String caption;
  final double? buttonHeight;
  const RectangularTextButton(
      {Key? key,
      required this.onPressed,
      required this.caption,
      this.buttonHeight})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: buttonHeight ?? context.height * 0.08,
        width: context.width * 0.36,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.greyColor,
        ),
        child: Center(
          child: AutoSizeText(
            caption,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
