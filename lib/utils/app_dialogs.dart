import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:hiring_task/widgets/loading/loading_widget.dart';

class AppDialogs {
  static BuildContext? dialogueContext;
  static Future<dynamic> loadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        dialogueContext = ctx;
        // return Container(
        //   color: AppColors.transparentColor,
        //   child: Center(
        //     child: SpinKitFadingCircle(
        //       color: AppColors.primaryColor,
        //       size: 30.0,
        //     ),
        //   ),
        // );
        return const LoadingWidget();
      },
    );
  }

  static void closeDialog() {
    Navigator.pop(dialogueContext!);
  }

  static bool exitDialog(BuildContext context) {
    bool? exitStatus = false;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Are you sure you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              loadingDialog(context);
              exitStatus = await FlutterExitApp.exitApp();
              closeDialog();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return exitStatus ?? false;
  }

  static likeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('You liked this recipe'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
