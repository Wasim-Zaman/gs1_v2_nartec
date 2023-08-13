import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hiring_task/providers/login_provider.dart';
import 'package:hiring_task/res/common/common.dart';
import 'package:hiring_task/utils/app_dialogs.dart';
import 'package:hiring_task/view-model/login/login_services.dart';
import 'package:hiring_task/view-model/login/reset-password/reset_password_services.dart';
import 'package:hiring_task/view/screens/log-in/gs1_member_login_screen.dart';
import 'package:hiring_task/view/screens/log-in/reset-password/reset_screen_two.dart';
import 'package:hiring_task/view/screens/member-screens/get_barcode_screen.dart';
import 'package:hiring_task/widgets/dropdown_widget.dart';
import 'package:hiring_task/widgets/required_text_widget.dart';
import 'package:provider/provider.dart';

class ResetScreenOne extends StatefulWidget {
  const ResetScreenOne({super.key});
  static const String routeName = 'reset-screen-one';

  @override
  State<ResetScreenOne> createState() => _ResetScreenOneState();
}

class _ResetScreenOneState extends State<ResetScreenOne> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  List<String> activities = [];
  String? activityValue;
  String? activityId;
  @override
  void dispose() {
    emailController.dispose();
    formKey.currentState?.deactivate();
    super.dispose();
  }

  Future<void> selectActivity() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 600,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RequiredTextWidget(title: "Select Activity"),
                const SizedBox(height: 10),
                FutureBuilder(
                    future: LoginServices.getActivities(
                        email: emailController.text),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: LinearProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("User on this email not found"),
                        );
                      }
                      final snap = snapshot.data;
                      final listOfAcitivies = snap;
                      activities = listOfAcitivies!
                          .where((activity) => (activity.activity != null ||
                              activity.activity != "null"))
                          .map((e) => e.activity.toString())
                          .toList();
                      activityId = listOfAcitivies
                          .where(
                              (element) => element.activity == activities.first)
                          .first
                          .activityID
                          .toString();
                      return DropdownWidget(
                        value: activityValue ?? activities.first,
                        list: activities,
                        onChanged: (value) {
                          setState(() {
                            activityValue = value;
                            activityId = listOfAcitivies
                                .where((element) =>
                                    element.activity == activityValue)
                                .first
                                .activityID
                                .toString();
                            Provider.of<LoginProvider>(context, listen: false)
                                .setActivity(activityValue);
                            Provider.of<LoginProvider>(context, listen: false)
                                .setEmail(emailController.text);
                            Navigator.of(context).pop();
                          });
                        },
                      );

                      // SizedBox(
                      //   width: double.infinity,
                      //   height: 60,
                      //   child: FittedBox(
                      //     child: SizedBox(
                      //       height: 100,
                      //       child: Card(
                      //         elevation: 5,
                      //         child: DropdownButton(
                      //             value: activityValue,
                      //             items: activities
                      //                 .where((element) => element.isNotEmpty)
                      //                 .map<DropdownMenuItem<String>>(
                      //                   (String v) => DropdownMenuItem<String>(
                      //                     value: v,
                      //                     child: FittedBox(child: Text(v)),
                      //                   ),
                      //                 )
                      //                 .toList(),
                      //             onChanged: (String? newValue) {
                      //               setState(() {
                      //                 activityValue = newValue!;
                      //                 Provider.of<LoginProvider>(context,
                      //                         listen: false)
                      //                     .setActivity(activityValue);
                      //                 Provider.of<LoginProvider>(context,
                      //                         listen: false)
                      //                     .setEmail(emailController.text);
                      //                 Navigator.of(context).pop();
                      //               });
                      //             }),
                      //       ),
                      //     ),
                      //   ),
                      // );
                    }),
              ],
            ),
          ),
        );
      },
    );
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
                const RequiredTextWidget(title: "Email Address"),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: emailController,
                  hintText: "Enter your email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    if (EmailValidator.validate(value) == false) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                activityValue != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const RequiredTextWidget(title: "Activity"),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(activityValue.toString()),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate() &&
                        activityValue == null) {
                      selectActivity().catchError(
                        (error) {
                          Common.showToast(
                            error
                                .toString()
                                .replaceAll("Exception: ", "Error: "),
                          );
                        },
                      );
                    } else {
                      AppDialogs.loadingDialog(context);
                      emailController.text =
                          Provider.of<LoginProvider>(context, listen: false)
                              .email
                              .toString();
                      activityValue =
                          Provider.of<LoginProvider>(context, listen: false)
                              .activity
                              .toString();
                      try {
                        ResetPasswordServices.forgotPassword(
                          emailController.text,
                          activityValue.toString(),
                          activityId.toString(),
                        ).then((value) {
                          AppDialogs.closeDialog();
                          Common.showToast(
                            "Sent verification code to your email",
                            backgroundColor: Theme.of(context).primaryColor,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetScreenTwo(
                                email: emailController.text,
                                activity: activityValue.toString(),
                                activityId: activityId.toString(),
                              ),
                            ),
                          );
                        }).catchError(
                          (error) {
                            AppDialogs.closeDialog();
                            Common.showToast(
                              error
                                  .toString()
                                  .replaceAll("Exception: ", "Error: "),
                            );
                          },
                        );
                      } catch (error) {
                        Common.showToast(
                          error.toString().replaceAll(
                                "Exception: ",
                                "Error: ",
                              ),
                        );
                      }
                    }
                  },
                  child: const Text("Send Verification Code"),
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
