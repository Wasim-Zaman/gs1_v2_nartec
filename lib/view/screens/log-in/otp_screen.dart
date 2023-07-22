// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hiring_task/res/common/common.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/view-model/login/login_services.dart';
import 'package:hiring_task/view/screens/log-in/after-login/dashboard/dashboard.dart';
import 'package:hiring_task/view/screens/log-in/widgets/logo/login_logo_widget.dart';
import 'package:hiring_task/widgets/required_text_widget.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});
  static const String routeName = "/otp_screen";

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  String? generatedOtp;

  @override
  void initState() {
    formKey.currentState?.save();
    Future.delayed(Duration.zero, () async {
      final args = ModalRoute.of(context)?.settings.arguments as Map;
      final email = args["email"];
      final activity = args["activity"];

      try {
        final response = await LoginServices.sendOTP(email, activity);

        Common.showToast(response["message"], backgroundColor: Colors.green);
        generatedOtp = response["otp"];
        otpController.text = response["otp"];
      } catch (e) {
        Common.showToast(e.toString(), backgroundColor: Colors.red);
        Future.delayed(const Duration(seconds: 2)).then((_) {
          Navigator.pop(context);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      appBar: AppBar(
        title: const Text("Please Enter Verification Code"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginLogoWidget(),
                const RequiredTextWidget(title: "Verify Code"),
                const SizedBox(height: 20),
                Pinput(
                  length: 6,
                  controller: otpController,
                  animationDuration: const Duration(seconds: 3),
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsRetrieverApi,
                  pinAnimationType: PinAnimationType.slide,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.length < 6 || value.length > 6) {
                      return "OTP must be six digits";
                    }
                    if (value.isEmpty) {
                      return "Please provide 6 digits OTP";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // TextFormField(
                //   controller: otpController,
                //   decoration: const InputDecoration(
                //       border: OutlineInputBorder(
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(20),
                //       bottomRight: Radius.circular(20),
                //     ),
                //   )),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "The field is required";
                //     }
                //     return null;
                //   },
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            final args = ModalRoute.of(context)
                                ?.settings
                                .arguments as Map;
                            final email = args["email"];
                            final activity = args["activity"];
                            final password = args['password'];
                            try {
                              final response = await LoginServices.confirmation(
                                email.toString(),
                                activity.toString(),
                                password.toString(),
                                generatedOtp.toString(),
                                otpController.text,
                              );
                              Common.showToast(
                                response.message.toString(),
                                backgroundColor: Colors.green,
                              );

                              Navigator.of(context).pushNamed(
                                Dashboard.routeName,
                                arguments: {
                                  'response': response,
                                  'userId': response.memberData?.user?.id,
                                },
                              );
                            } catch (e) {
                              Common.showToast(
                                e.toString(),
                                backgroundColor: Colors.red,
                              );
                            }
                          }
                        },
                        child: const Text('Confirm')),
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
