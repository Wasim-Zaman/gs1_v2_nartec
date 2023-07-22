// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hiring_task/constants/colors/app_colors.dart';
import 'package:hiring_task/view/screens/home/home_screen.dart';

AppBar HomeAppBarWidget(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    foregroundColor: AppColors.whiteColor,
    title: const Text('Home'),
    leading: IconButton(
      onPressed: () {
        Navigator.pushNamed(context, HomeScreen.routeName);
      },
      icon: const Icon(
        Icons.home_outlined,
        size: 30,
      ),
    ),
  );
}
