import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ScanEventScreen extends StatelessWidget {
  const ScanEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          QRScannerHint(),
        ],
      ),
    );
  }
}

class QRScannerHint extends StatefulWidget {
  const QRScannerHint({super.key});

  @override
  State<QRScannerHint> createState() => _QRScannerHintState();
}

class _QRScannerHintState extends State<QRScannerHint> {
  bool showHint = true;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return Visibility(
      visible: showHint,
      child: Container(
        height: 30.h,
        width: 100.w,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
          color: primaryColor,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 5.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  showHint = false;
                });
              },
              icon: Image.asset(
                "assets/icons/close.png",
                color: Colors.white,
                height: 4.h,
                width: 4.w,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "Align QR Code Within Frame To Scan",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
