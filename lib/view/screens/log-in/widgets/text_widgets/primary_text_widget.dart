import 'package:flutter/material.dart';

class PrimaryTextWidget extends StatelessWidget {
  const PrimaryTextWidget(
      {Key? key, required this.text, this.fontSize, this.fontWeight})
      : super(key: key);
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 20,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
