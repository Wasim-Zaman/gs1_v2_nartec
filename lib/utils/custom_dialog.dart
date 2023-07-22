import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  CustomDialog.error(
    BuildContext context, {
    String? title,
    String? desc,
    DialogType? dialogType,
    AnimType? animType,
    VoidCallback? btnCancelOnPress,
    VoidCallback? btnOkOnPress,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType ?? DialogType.error,
      animType: animType ?? AnimType.scale,
      title: title ?? 'Error',
      desc: desc ?? 'Please select an activity and give a password',
      btnCancelOnPress: btnCancelOnPress ?? () {},
      btnOkOnPress: btnOkOnPress ?? () {},
    ).show();
  }

  CustomDialog.success(
    BuildContext context, {
    String? title,
    String? desc,
    DialogType? dialogType,
    AnimType? animType,
    VoidCallback? btnCancelOnPress,
    VoidCallback? btnOkOnPress,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType ?? DialogType.success,
      animType: animType ?? AnimType.bottomSlide,
      title: title ?? 'Success',
      desc: desc ?? 'The operation completed successfully',
      btnCancelOnPress: btnCancelOnPress ?? () {},
      btnOkOnPress: btnOkOnPress ?? () {},
    ).show();
  }
}
