import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String? caption;
  final Color? bgColor;
  final Color? textColor;
  final double? buttonWidth;
  final VoidCallback? onPressed;
  final EdgeInsets? margin;

  const CustomElevatedButton({
    super.key,
    this.caption,
    this.bgColor,
    this.buttonWidth,
    this.onPressed,
    this.margin,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(right: 10),
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor ?? Colors.white,
          backgroundColor: bgColor ?? Colors.purple,
          padding: const EdgeInsets.all(8),
        ),
        child: Text(caption ?? 'Text'),
      ),
    );
  }
}
