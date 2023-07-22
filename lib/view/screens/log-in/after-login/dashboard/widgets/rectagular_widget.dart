import 'package:flutter/material.dart';
import 'package:hiring_task/view/screens/log-in/widgets/text_widgets/primary_text_widget.dart';

class RectangularWidget extends StatelessWidget {
  const RectangularWidget({
    Key? key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
  }) : super(key: key);
  final String text1, text2, text3, text4;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryTextWidget(text: text1),
            PrimaryTextWidget(text: text2),
            const SizedBox(height: 5),
            Divider(thickness: 1, color: Theme.of(context).primaryColor),
            const SizedBox(height: 5),
            PrimaryTextWidget(text: text3),
            PrimaryTextWidget(text: text4),
          ],
        ),
      ),
    );
  }
}
