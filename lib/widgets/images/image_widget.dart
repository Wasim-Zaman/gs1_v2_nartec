import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
    BuildContext context, {
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.alignment,
  }) : super(key: key);
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Alignment? alignment;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        imageUrl,
        height: height ?? MediaQuery.of(context).size.height * 0.2,
        width: width ?? MediaQuery.of(context).size.width,
        fit: fit ?? BoxFit.cover,
        alignment: alignment ?? Alignment.center,
        errorBuilder: (context, error, stackTrace) => Placeholder(
          color: Theme.of(context).primaryColor,
          fallbackHeight: MediaQuery.of(context).size.height * 0.2,
          fallbackWidth: double.infinity,
        ),
      ),
    );
  }
}
