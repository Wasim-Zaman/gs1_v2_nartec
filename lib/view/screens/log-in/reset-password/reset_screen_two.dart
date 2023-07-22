import 'package:flutter/material.dart';
import 'package:hiring_task/providers/login_provider.dart';
import 'package:hiring_task/res/common/common.dart';
import 'package:hiring_task/view-model/login/reset-password/reset_password_services.dart';
import 'package:hiring_task/view/screens/log-in/gs1_member_login_screen.dart';
import 'package:hiring_task/view/screens/log-in/reset-password/reset_screen_three.dart';
import 'package:hiring_task/view/screens/member-screens/get_barcode_screen.dart';
import 'package:hiring_task/widgets/required_text_widget.dart';
import 'package:provider/provider.dart';

class ResetScreenTwo extends StatefulWidget {
  const ResetScreenTwo({super.key});
  static const String routeName = 'reset-screen-two';

  @override
  State<ResetScreenTwo> createState() => _ResetScreenTwoState();
}

class _ResetScreenTwoState extends State<ResetScreenTwo> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();

  verifyCode() {
    final email = Provider.of<LoginProvider>(context, listen: false).email;
    final activity = Provider.of<LoginProvider>(context, listen: false).activity;
    Provider.of<LoginProvider>(context, listen: false).setOtp(
      codeController.text,
    );

    try {
      ResetPasswordServices.verifyCode(
        email.toString(),
        activity.toString(),
        codeController.text,
      ).then((_) {
        Common.showToast("Create your new password");
        Navigator.pushNamed(
          context,
          ResetScreenThree.routeName,
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
