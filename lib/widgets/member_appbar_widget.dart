import 'package:flutter/material.dart';
import 'package:hiring_task/utils/colors.dart';

AppBar memberAppBarWidget({
  String? title,
  bool? centerTitle,
  Color? backgroundColor,
  Color? foregroundColor,
}) {
  return AppBar(
    title: Text(title ?? "Title"),
    centerTitle: centerTitle ?? true,
    backgroundColor: backgroundColor ?? whiteColor,
    foregroundColor: foregroundColor ?? darkBlue.shade900,
  );
}
