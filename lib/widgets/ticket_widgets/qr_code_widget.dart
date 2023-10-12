import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../models/ticket.dart';

class QrCodeWidget extends StatelessWidget {
  const QrCodeWidget({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    // check device mode
    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    // qrCode color (changes dynamically according to device theme mode)
    Color qrColor = Colors.black;

    return SizedBox(
      height: 30.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // some space
          SizedBox(
            height: 2.h,
          ),

          // ticket qr code for validation
          QrImageView(
            data: ticket.ticketId,
            version: QrVersions.auto,
            size: 120.sp,
            eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.circle,
              color: qrColor,
            ),
            dataModuleStyle: QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.circle,
              color: qrColor,
            ),
          ),

          // some space
          SizedBox(
            height: 5.h,
          ),

          // ticket instruction
          Text(
            "Simply tap the event title for comprehensive details.",
            style: TextStyle(fontSize: 8.sp),
          ),
        ],
      ),
    );
  }
}
