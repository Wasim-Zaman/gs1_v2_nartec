import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/view-model/login/login_services.dart';
import 'package:hiring_task/view/screens/log-in/otp_screen.dart';
import 'package:hiring_task/view/screens/log-in/widgets/logo/login_logo_widget.dart';
import 'package:hiring_task/view/screens/log-in/widgets/text_fields/password_text_field_widget.dart';
import 'package:hiring_task/widgets/required_text_widget.dart';

class SelectActivityAndPasswordScreen extends StatefulWidget {
  const SelectActivityAndPasswordScreen({Key? key}) : super(key: key);
  static const String routeName = "/select_activity_&_password_screen";

  @override
  State<SelectActivityAndPasswordScreen> createState() =>
      _SelectActivityAndPasswordScreenState();
}

class _SelectActivityAndPasswordScreenState
    extends State<SelectActivityAndPasswordScreen> {
  List<String> activities = [];
  String? activityValue;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  showOtpPopup(String message,
      {String? email, String? activity, String? password}) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: 'OTP',
      desc: message,
      btnOkOnPress: () {
        Navigator.pop(context);
        Navigator.of(context).pushNamed(
          OTPScreen.routeName,
          arguments: {
            "email": email,
            "activity": activity,
            "password": password,
          },
        );
      },
      btnOkIcon: Icons.check_circle,
      onDismissCallback: (_) {
        Navigator.pop(context);
      },
    ).show();
  }

  @override
  void initState() {
    formKey.currentState?.save();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      backgroundColor: bgGrey,
      appBar: AppBar(
        title: const Text("Select Activity & Password"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            const LoginLogoWidget(),
            const RequiredTextWidget(title: "Activity"),
            const SizedBox(height: 10),
            FutureBuilder(
                future: LoginServices.getActivities(email: email),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                          height: 50, child: LinearProgressIndicator()),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                              'An error occured, please refresh the page'),
                          TextButton.icon(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: const Icon(Icons.refresh_rounded),
                            label: const Text('Refresh'),
                          ),
                        ],
                      ),
                    );
                  }
                  final snap = snapshot.data as Map<String, dynamic>;
                  final listOfAcitivies = snap['activities'] as List;
                  activities = listOfAcitivies
                      .where((activity) => activity != null)
                      .map((e) => e.toString())
                      .toList();
                  return SizedBox(
                    child: Card(
                      color: bgGrey,
                      elevation: 5,
                      child: DropdownButton(
                          value: activityValue,
                          dropdownColor: bgGrey,
                          focusColor: bgGrey,
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(10),
                          items: activities
                              .where((element) => element != null)
                              .map<DropdownMenuItem<String>>(
                                (String v) => DropdownMenuItem<String>(
                                  value: v,
                                  child: AutoSizeText(
                                    v,
                                    maxLines: 2,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              activityValue = newValue!;
                            });
                          }),
                    ),
                  );
                }),
            const SizedBox(height: 20),
            const RequiredTextWidget(title: "Password"),
            const SizedBox(height: 10),
            Form(
              key: formKey,
              child: PasswordTextFieldWidget(
                controller: passwordController,
                validator: (password) {
                  if (password!.isEmpty || password == null) {
                    return "Please provide password";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  formKey.currentState?.save();
                  if (activityValue != null &&
                      passwordController.text.isNotEmpty) {
                    // Common.showToast(
                    //   'Please Wait For Admin Approval',
                    //   backgroundColor: Colors.blue,
                    // );
                    LoginServices.loginWithPassword(
                            email, activityValue!, passwordController.text)
                        .then((value) {
                      final message = value['message'] as String;

                      showOtpPopup(
                        message,
                        email: email,
                        activity: activityValue,
                        password: passwordController.text,
                      );
                    }).onError((error, stackTrace) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.topSlide,
                        title: 'Error',
                        desc: error.toString().replaceAll('Exception:', ''),
                        btnOkOnPress: () {},
                        btnOkIcon: Icons.check_circle,
                        onDismissCallback: (_) {},
                      ).show();
                    });
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.bottomSlide,
                      title: 'Warning',
                      desc: 'Please select an activity and give a password',
                      btnOkOnPress: () {},
                      btnOkIcon: Icons.check_circle,
                      onDismissCallback: (_) {},
                    ).show();
                  }
                }
              },
              child: const Text("Login Now"),
            ),
          ],
        ),
      ),
    );
  }
}
