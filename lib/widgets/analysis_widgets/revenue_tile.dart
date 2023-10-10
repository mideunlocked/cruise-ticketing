import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/format_number.dart';

class RevenueTile extends StatelessWidget {
  const RevenueTile({
    super.key,
    required this.data,
    required this.title,
  });

  final double data;
  final String title;

  @override
  Widget build(BuildContext context) {
    String dataString = FormatNumber.formatLargeNumber(
      data.toInt(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        Text(
          dataString,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 25.sp,
          ),
        ),
      ],
    );
  }
}
