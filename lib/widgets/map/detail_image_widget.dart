import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DetailImageWidget extends StatelessWidget {
  const DetailImageWidget({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        image,
        height: 15.h,
        width: 35.w,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(
          Icons.error,
        ),
      ),
    );
  }
}
