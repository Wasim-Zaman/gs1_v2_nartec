import 'package:flutter/material.dart';
import 'package:hiring_task/providers/login_provider.dart';
import 'package:hiring_task/res/common/common.dart';
import 'package:hiring_task/utils/app_dialogs.dart';
import 'package:hiring_task/view-model/login/reset-password/reset_password_services.dart';
import 'package:hiring_task/view/screens/log-in/gs1_member_login_screen.dart';
import 'package:hiring_task/view/screens/log-in/reset-password/reset_screen_three.dart';
import 'package:hiring_task/view/screens/member-screens/get_barcode_screen.dart';
import 'package:hiring_task/widgets/required_text_widget.dart';
import 'package:provider/provider.dart';

class ResetScreenTwo extends StatefulWidget {
  final String email, activity, activityId;

  static const String routeName = 'reset-screen-two';

  const ResetScreenTwo({
    super.key,
    required this.email,
    required this.activity,
    required this.activityId,
  });

  @override
  State<ResetScreenTwo> createState() => _ResetScreenTwoState();
}

class _ResetScreenTwoState extends State<ResetScreenTwo> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();

  verifyCode() {
    AppDialogs.loadingDialog(context);
    final email = widget.email;
    final activity = widget.activity;
    Provider.of<LoginProvider>(context, listen: false).setOtp(
      codeController.text,
    );

    final activityId = widget.activityId;

    try {
      ResetPasswordServices.verifyCode(
        email.toString(),
        activity.toString(),
        activityId.toString(),
        codeController.text.trim(),
      ).then((_) {
        AppDialogs.closeDialog();
        Common.showToast("Create your new password");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetScreenThree(
              email: email,
              activity: activity,
              activityId: activityId,
            ),
          ),
        );
        // Navigator.pushNamed(
        //   context,
        //   ResetScreenThree.routeName,
        // );
      }).catchError((e) {
        AppDialogs.closeDialog();

        Common.showToast(e.toString(), backgroundColor: Colors.red);
      });
    } catch (e) {
      AppDialogs.closeDialog();

      Common.showToast(e.toString(), backgroundColor: Colors.red);
    }
  }

  @override
  void dispose() {
    codeController.dispose();
    formKey.currentState?.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          title: const Text("Reset Password"),
          centerTitle: true,
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RequiredTextWidget(title: "Verify Code"),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: codeController,
                  hintText: "00000",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter verification code";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      verifyCode();
                    }
                  },
                  child: const Text("Verify Now"),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text("Login Again?"),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Gs1MemberLoginScreen.routeName,
                        );
                      },
                      child: const Text("Login Now"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
