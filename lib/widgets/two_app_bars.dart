import 'package:flutter/material.dart';
import 'package:hiring_task/utils/colors.dart';

class TwoAppBars extends StatelessWidget {
  final Color? firstBgColor;
  final Color? firstFgColor;
  final Color? secondBgColor;
  final String? firstText;
  final String? secondText;
  final IconData? firstLeadingIcon;
  final List<Widget>? firstActions;
  const TwoAppBars({
    super.key,
    this.firstBgColor,
    this.secondBgColor,
    this.firstText,
    this.secondText,
    this.firstLeadingIcon,
    this.firstActions,
    this.firstFgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: firstBgColor ?? Color.fromARGB(255, 14, 91, 60),
          foregroundColor: firstFgColor ?? pinkColor,
          title: Text(firstText ?? "Republic Of Utopia"),
          automaticallyImplyLeading: false,
          leading: Icon(firstLeadingIcon, size: 40),
          actions: firstActions,
        ),
        AppBar(
          backgroundColor:
              secondBgColor ?? const Color.fromARGB(255, 22, 54, 24),
          title: Text(secondText ?? "Safety Information"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
