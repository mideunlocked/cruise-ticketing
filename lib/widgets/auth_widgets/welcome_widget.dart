import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/welcome.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
    required this.data,
    required this.currentIndex,
    required this.pageController,
  });

  final Welcome data;
  final int currentIndex;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;
    const primaryColor = Colors.black;
    var widgetShadow = BoxShadow(
      color: Colors.white24,
      blurRadius: 20.sp,
      spreadRadius: 2,
    );

    var textShadow = const [
      Shadow(
        color: Colors.black,
        blurRadius: 10,
      ),
    ];

    return Stack(
      children: [
        ColorFiltered(
          colorFilter: const ColorFilter.mode(
            Colors.grey,
            BlendMode.saturation,
          ),
          child: Image.asset(
            data.imageUrl,
            fit: BoxFit.cover,
            height: 100.h,
            width: 100.w,
          ),
        ),
        Positioned(
          top: 5.h,
          left: 80.w,
          child: TextButton(
            onPressed: () => navigateToLetScreen(context),
            child: Text(
              "Skip",
              style: bodyMedium?.copyWith(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: TextStyle(
                  fontSize: 30.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                  shadows: textShadow,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                data.subtitle,
                style: TextStyle(
                  color: Colors.white,
                  shadows: textShadow,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 1.1.h,
                width: 100.w,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: welcomeMessages.length,
                  itemBuilder: (ctx, index) {
                    bool isCurrent = index == currentIndex;

                    return Container(
                      width: isCurrent ? 10.w : 2.w,
                      margin: EdgeInsets.symmetric(horizontal: 1.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isCurrent ? primaryColor : Colors.white,
                        boxShadow: [widgetShadow],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
        Positioned(
          top: 90.h,
          left: currentIndex == 2 ? 58.w : 68.w,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [widgetShadow],
            ),
            child: FloatingActionButton.extended(
              backgroundColor: primaryColor,
              onPressed: () {
                if (currentIndex < 2) {
                  pageController.nextPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                  return;
                }

                navigateToLetScreen(context);
              },
              label: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  currentIndex == 2 ? "Get started" : "Next",
                  style: bodyMedium?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void navigateToLetScreen(BuildContext ctx) {
    Navigator.pushNamed(
      ctx,
      "/LetYouInScreen",
    );
  }
}
