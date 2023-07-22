import 'package:flutter/material.dart';
import 'package:hiring_task/utils/colors.dart';

AppBar customAppBarWidget({
  String? title,
  IconData? icon,
  List<Widget>? actions,
  Color? backgroundColor,
  Color? foregroundColor,
}) {
  return AppBar(
    title: Text(
      title ?? "Retailer",
      softWrap: true,
    ),
    elevation: 0,
    foregroundColor: foregroundColor ?? whiteColor,
    backgroundColor: backgroundColor ?? yellowAppBarColor,
    // leading: Icon(
    //   icon ?? Icons.shopping_bag_outlined,
    // ),
    actions: actions ?? [],
  );
}
