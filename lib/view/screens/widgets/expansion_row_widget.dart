// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ExpansionRowWidget extends StatelessWidget {
  String keyy;
  String value;
  double? fontSize;

  ExpansionRowWidget({
    super.key,
    required this.keyy,
    required this.value,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            keyy,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: fontSize ?? 12,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 10,
          ),
        ),
        const Expanded(
          flex: 1,
          child: Text(''),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: fontSize ?? 11,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 10,
          ),
        ),
      ],
    );
  }
}
