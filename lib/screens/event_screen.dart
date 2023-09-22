import 'package:cruise/widgets/general_widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import '../widgets/general_widgets/custom_back_button.dart';

class EventScreen extends StatefulWidget {
  static const routeName = "/EventScreen";

  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  Map<String, dynamic> data = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
  }

  bool isAbout = true;
  bool isDetails = false;

  void toggleTab() {
    setState(() {
      isAbout == true
          ? {
              isAbout = false,
              isDetails = true,
            }
          : {
              isDetails = false,
              isAbout = true,
            };
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 3.h);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                EventImageWidget(
                  imageUrl: data["imageUrl"] ?? "",
                ),
                Positioned(
                  top: 46.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data["name"] ?? "",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w900,
                            // color:
                            //     MediaQuery.platformBrightnessOf(context) ==
                            //             Brightness.light
                            //         ? primaryColor
                            //         : null,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        CustomTabBar(
                          toggleTab: toggleTab,
                          isAbout: isAbout,
                          isDetails: isDetails,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const AboutHost(),
            sizedBox,
            const PaddedWidgetEventScreen(
                child: EventScreenTitleWidget(title: "DESCRIPTION")),
            SizedBox(
              height: 2.h,
            ),
            DescriptionTextWidget(description: data["description"] ?? ""),
            sizedBox,
            Container(
              height: 8.h,
              width: 15.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.black87.withOpacity(0.8),
                    Colors.black12,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              alignment: Alignment.center,
              child: Image.asset(
                "assets/icons/calendar.png",
                height: 6.h,
                width: 6.w,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptionTextWidget extends StatelessWidget {
  const DescriptionTextWidget({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.bold,
      color: Colors.amber,
    );
    return PaddedWidgetEventScreen(
      child: ReadMoreText(
        description,
        trimLines: 6,
        colorClickableText: Colors.pink,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'Show more',
        trimExpandedText: 'Show less',
        moreStyle: textStyle,
        lessStyle: textStyle,
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {super.key,
      required this.toggleTab,
      required this.isAbout,
      required this.isDetails});

  final Function toggleTab;
  final bool isAbout, isDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92.w,
      height: 6.h,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? Colors.grey[300]
            : const Color.fromARGB(255, 0, 2, 51),
      ),
      child: Row(
        children: [
          TabWidget(
            title: "About",
            check: isAbout,
            toggleTab: () => toggleTab(),
          ),
          TabWidget(
            title: "Details",
            check: isDetails,
            toggleTab: () => toggleTab(),
          ),
        ],
      ),
    );
  }
}

class AboutHost extends StatelessWidget {
  const AboutHost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    const color2 = Colors.green;

    return PaddedWidgetEventScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EventScreenTitleWidget(title: "HOST"),
          Row(
            children: [
              ProfileImage(
                imageUrl:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTApbxj4499GJJWMYvKUVnzMUBJBt1b_Aob0A&usqp=CAU",
                radius: 17.sp,
              ),
              SizedBox(width: 2.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "John Doe",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      // color: MediaQuery.platformBrightnessOf(
                      //             context) ==
                      //         Brightness.light
                      //     ? primaryColor
                      //     : null,
                    ),
                  ),
                  Text(
                    "@johndoe",
                    style: TextStyle(
                      color: MediaQuery.platformBrightnessOf(context) ==
                              Brightness.light
                          ? color2
                          : primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EventScreenTitleWidget extends StatelessWidget {
  const EventScreenTitleWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    const color2 = Colors.green;

    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? color2
            : primaryColor,
      ),
    );
  }
}

class PaddedWidgetEventScreen extends StatelessWidget {
  const PaddedWidgetEventScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: child,
    );
  }
}

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.title,
    required this.check,
    required this.toggleTab,
  });

  final Function toggleTab;
  final String title;
  final bool check;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    return InkWell(
      onTap: () => toggleTab(),
      child: Container(
        height: double.infinity,
        width: 46.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: check == true
              ? MediaQuery.platformBrightnessOf(context) == Brightness.light
                  ? Colors.black
                  : primaryColor
              : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: check == true ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}

class EventImageWidget extends StatelessWidget {
  const EventImageWidget({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return const LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Stack(
        children: [
          Image.network(
            imageUrl,
            height: 60.h,
            width: 100.w,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 5.h,
            left: 2.w,
            child: const CustomBackButton(),
          ),
        ],
      ),
    );
  }
}
