import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.network(
          imageUrl.toString(),
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Placeholder(
            fallbackHeight: 100,
            fallbackWidth: 100,
            child: Icon(
              Icons.error,
              color: Colors.red,
              size: 100,
            ),
          ),
        ),
      ),
    );
  }
}
