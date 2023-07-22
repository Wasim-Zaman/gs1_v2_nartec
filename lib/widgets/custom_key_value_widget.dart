import 'package:flutter/material.dart';
import 'package:hiring_task/utils/colors.dart';

class CustomKeyValueWidget extends StatelessWidget {
  const CustomKeyValueWidget({
    super.key,
    this.value,
    this.heading,
    this.headFlex,
    this.valueFlex,
    this.height,
  });

  final String? value;
  final String? heading;
  final int? headFlex;
  final int? valueFlex;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: headFlex ?? 3,
            child: Container(
              alignment: Alignment.center,
              height: height ?? MediaQuery.of(context).size.height * 0.07,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: Text(
                heading ?? 'Key',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 18,
                  color: darkBlue,
                ),
              ),
            ),
          ),
          Expanded(
            flex: valueFlex ?? 2,
            child: Container(
              alignment: Alignment.center,
              height: height ?? MediaQuery.of(context).size.height * 0.07,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: Text(
                value ?? 'Value',
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 18, color: blackColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
