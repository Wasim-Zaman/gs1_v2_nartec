import 'package:flutter/material.dart';

class LoginLogoWidget extends StatelessWidget {
  const LoginLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 5),
          // decoration: BoxDecoration(border: Border.all()),
          child: Image.asset(
            'assets/images/logo.png',
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
          ),
        ),
        Image.asset(
          'assets/images/barcode_without_text_image.png',
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          width: double.infinity,
        ),
        const SizedBox(height: 30),
        Divider(
          thickness: 4,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
