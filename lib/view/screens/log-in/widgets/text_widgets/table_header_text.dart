import 'package:flutter/material.dart';

class TableHeaderText extends StatelessWidget {
  const TableHeaderText({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white),
    );
  }
}
