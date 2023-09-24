import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

import '../data.dart';
import '../widgets/general_widgets/custom_app_bar.dart';
import 'event_screen.dart';

class TicketScreen extends StatelessWidget {
  static const routeName = "/TicketScreen";

  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    var detailTileEdgeInsets = EdgeInsets.only(left: 6.w, right: 4.w);

    bool checkMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.light;
    Color qrColor = checkMode ? Colors.black : Colors.white;

    var data = event[0];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            padWidget(
              child: const CustomAppBar(
                title: "My Ticket",
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                padWidget(
                  child: Container(
                    height: 78.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor, width: 2.0),
                      color: primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 30.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              QrImageView(
                                data: '1234567890',
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
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "Simply tap the event title for comprehensive details.",
                                style: TextStyle(fontSize: 8.sp),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                          child: Column(
                            children: [
                              Padding(
                                padding: detailTileEdgeInsets,
                                child: SizedBox(
                                  width: 90.w,
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) => EventScreen(
                                          durationData: const {},
                                          eventData: data,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      data["name"] ?? "",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 2.0,
                                        wordSpacing: 4.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              ticketDetailTile(
                                primaryColor: primaryColor,
                                edgeInsets: detailTileEdgeInsets,
                                iconUrl: "calendar",
                                text: data["date"] ?? "",
                              ),
                              ticketDetailTile(
                                primaryColor: primaryColor,
                                edgeInsets: detailTileEdgeInsets,
                                iconUrl: "clock",
                                text: data["time"] ?? "",
                              ),
                              ticketDetailTile(
                                primaryColor: primaryColor,
                                edgeInsets: detailTileEdgeInsets,
                                iconUrl: "placeholder",
                                text: data["venue"] ?? "",
                              ),
                              Container(
                                height: 5.h,
                                width: 100.w,
                                color: primaryColor.withOpacity(0.2),
                                margin: EdgeInsets.only(top: 3.h),
                                padding: detailTileEdgeInsets,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data["pricing"][1]["category"] ?? ""),
                                    Text(
                                      data["pricing"][1]["price"] ?? "",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cutContainer(of),
                    SizedBox(
                      width: 58.w,
                      height: 3.0,
                      child: ListView.builder(
                        itemCount: 58.w ~/ 4.w,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) => Container(
                          width: 4.w,
                          margin: EdgeInsets.symmetric(horizontal: 1.w),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    cutContainer(of),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding ticketDetailTile({
    required Color primaryColor,
    required EdgeInsets edgeInsets,
    required String iconUrl,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 6.w, right: 2.w),
      child: Row(
        children: [
          Image.asset(
            "assets/icons/$iconUrl.png",
            height: 5.h,
            width: 5.w,
            color: primaryColor,
          ),
          SizedBox(
            width: 3.w,
          ),
          Text(text),
        ],
      ),
    );
  }

  Container cutContainer(ThemeData of) {
    return Container(
      height: 15.h,
      width: 20.w,
      decoration: BoxDecoration(
        color: of.scaffoldBackgroundColor,
        shape: BoxShape.circle,
      ),
    );
  }

  Padding padWidget({required Widget child}) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8.w,
        right: 8.w,
        top: 1.h,
      ),
      child: child,
    );
  }
}
