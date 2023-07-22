import 'package:flutter/material.dart';
import 'package:hiring_task/providers/login_provider.dart';
import 'package:hiring_task/res/common/common.dart';
import 'package:hiring_task/view-model/login/reset-password/reset_password_services.dart';
import 'package:hiring_task/view/screens/log-in/gs1_member_login_screen.dart';
import 'package:hiring_task/view/screens/member-screens/get_barcode_screen.dart';
import 'package:hiring_task/widgets/required_text_widget.dart';
import 'package:provider/provider.dart';

class ResetScreenThree extends StatefulWidget {
  const ResetScreenThree({super.key});
  static const String routeName = 'reset-screen-three';

  @override
  State<ResetScreenThree> createState() => _ResetScreenThreeState();
}

class _ResetScreenThreeState extends State<ResetScreenThree> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  resetPassword() {
    final email = Provider.of<LoginProvider>(context, listen: false).email;
    final activity = Provider.of<LoginProvider>(context, listen: false).activity;

    try {
      ResetPasswordServices.resetPassword(
        email.toString(),
        activity.toString(),
        newPasswordController.text,
        confirmPasswordController.text,
      ).then((_) {
        Common.showToast("Password reset successfully");
        Navigator.pushNamedAndRemoveUntil(
          context,
          Gs1MemberLoginScreen.routeName,
          (route) => false,
        );
      }).catchError((e) {
        Common.showToast(e.toString(), backgroundColor: Colors.red);
      });
    } catch (e) {
      Common.showToast(e.toString(), backgroundColor: Colors.red);
    }
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    formKey.currentState?.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          title: const Text("Enter New Password"),
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
                const RequiredTextWidget(title: "New Password"),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: newPasswordController,
                  hintText: "**********",
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const RequiredTextWidget(title: "Confirm Password"),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: confirmPasswordController,
                  hintText: "**********",
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return "Please enter password";
                    }
                    if (password != newPasswordController.text) {
                      return "Password does not match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      resetPassword();
                    }
                  },
                  child: const Text("Reset Password"),
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
