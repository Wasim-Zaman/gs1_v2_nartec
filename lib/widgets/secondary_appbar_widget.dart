import 'package:flutter/material.dart';

class SecondaryAppBarWidget extends StatelessWidget {
  const SecondaryAppBarWidget({
    super.key,
    this.leadingIcon,
    this.title1,
    this.title2,
    this.actions,
    this.color,
    this.backgroundColor,
    this.foregroundColor,
  });

  final IconData? leadingIcon;
  final String? title1;
  final String? title2;
  final List<Widget>? actions;
  final Color? color;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      foregroundColor: foregroundColor ?? Colors.black,
      leading: Icon(
        leadingIcon ?? Icons.shopping_cart_outlined,
        color: color ?? Colors.amber,
      ),
      title: RichText(
        text: TextSpan(
          text: title1 ?? "Retailer",
          style: TextStyle(
            color: color ?? Colors.amber,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: title2 ?? " Utility",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
