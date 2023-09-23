import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import '../widgets/general_widgets/custom_back_button.dart';
import '../widgets/general_widgets/profile_image.dart';

class EventScreen extends StatefulWidget {
  static const routeName = "/EventScreen";

  const EventScreen({
    super.key,
    required this.durationData,
    required this.eventData,
  });

  final Map<String, dynamic> durationData;
  final Map<String, dynamic> eventData;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
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
                  imageUrl: widget.eventData["imageUrl"] ?? "",
                ),
                Positioned(
                  top: 48.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 90.w,
                          child: Text(
                            widget.eventData["name"] ?? "",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0,
                              wordSpacing: 4.0,
                            ),
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
            isAbout == true
                ? About(
                    sizedBox: sizedBox,
                    widget: widget,
                  )
                : Details(
                    widget: widget,
                    sizedBox: sizedBox,
                  ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
      floatingActionButton: BuyTicketButton(
        pricing: widget.eventData["pricing"] ?? "",
      ),
    );
  }
}

class BuyTicketButton extends StatelessWidget {
  const BuyTicketButton({
    super.key,
    required this.pricing,
  });

  final List<dynamic> pricing;

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.6), // Glow color
            blurRadius: 20.0, // Spread of the glow
            spreadRadius: 2.0, // Spread radius
          ),
        ],
      ),
      child: FloatingActionButton(
        backgroundColor: primaryColor,
        heroTag: "buy-ticket",
        onPressed: () => showBuyTicket(context, pricing),
        child: Image.asset(
          "assets/icons/ticket-office.png",
          height: 8.h,
          width: 8.w,
          color: Colors.white,
        ),
      ),
    );
  }

  void showBuyTicket(BuildContext context, List<dynamic> pricing) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          return TicketPricingDialog(
            pricing: pricing,
          );
        });
  }
}

class TicketPricingDialog extends StatefulWidget {
  const TicketPricingDialog({
    super.key,
    required this.pricing,
  });

  final List<dynamic> pricing;

  @override
  State<TicketPricingDialog> createState() => _TicketPricingDialogState();
}

class _TicketPricingDialogState extends State<TicketPricingDialog> {
  var selectedIndex = -1;
  String selectedPrice = "";

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;

    return Container(
      height: double.infinity,
      color: scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.h,
          ),
          Text(
            "Buy Ticket",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: primaryColor,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.pricing.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (ctx, index) => InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    selectedPrice = widget.pricing[index]["price"];
                  });
                },
                child: PricingWidget(
                  e: widget.pricing[index],
                  selectedIndex: selectedIndex,
                  index: index,
                ),
              ),
            ),
          ),
          CustomButton(
            title: "Purchase",
            function: () {
              var price = selectedPrice.split(" ");
              print(price[1]);
            },
          ),
        ],
      ),
    );
  }
}

class PricingWidget extends StatelessWidget {
  const PricingWidget({
    super.key,
    required this.e,
    required this.index,
    required this.selectedIndex,
  });

  final dynamic e;
  final int index, selectedIndex;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    bool isSelected = selectedIndex == index || selectedIndex == -1;

    return Container(
      height: 8.h,
      width: 100.w,
      margin: EdgeInsets.symmetric(
        vertical: 1.h,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 2.h,
        horizontal: 4.w,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            e["category"] ?? "",
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 2.0,
              color: isSelected ? null : bodyMedium?.color?.withOpacity(0.4),
            ),
          ),
          Text(
            e["price"] ?? "",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 14.sp,
              color: isSelected ? primaryColor : primaryColor.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.function,
  });

  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return InkWell(
      onTap: () => function(),
      child: Container(
        width: 100.w,
        height: 5.h,
        margin: EdgeInsets.symmetric(
          vertical: 1.h,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MediaQuery.platformBrightnessOf(context) == Brightness.light
                ? Colors.white
                : null,
          ),
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.widget,
    required this.sizedBox,
  });

  final EventScreen widget;
  final SizedBox sizedBox;

  @override
  Widget build(BuildContext context) {
    List<dynamic> features = widget.eventData["features"] ?? "";

    return PaddedWidgetEventScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.h,
          ),
          const EventScreenTitleWidget(title: "RULES"),
          SizedBox(
            height: 2.h,
          ),
          Text(widget.eventData["rules"] ?? ""),
          sizedBox,
          const EventScreenTitleWidget(title: "FEATURES"),
          FeatureGridView(features: features),
        ],
      ),
    );
  }
}

class FeatureGridView extends StatelessWidget {
  const FeatureGridView({
    super.key,
    required this.features,
  });

  final List features;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 4.w,
        mainAxisExtent: 5.h,
      ),
      children: features
          .map(
            (e) => FeaturesTileWidget(
              title: e,
            ),
          )
          .toList(),
    );
  }
}

class FeaturesTileWidget extends StatelessWidget {
  const FeaturesTileWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? Colors.black38
            : Colors.white12,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}

class About extends StatelessWidget {
  const About({
    super.key,
    required this.sizedBox,
    required this.widget,
  });

  final SizedBox sizedBox;
  final EventScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AboutHost(),
        sizedBox,
        const PaddedWidgetEventScreen(
            child: EventScreenTitleWidget(title: "DESCRIPTION")),
        SizedBox(
          height: 2.h,
        ),
        DescriptionTextWidget(
            description: widget.eventData["description"] ?? ""),
        sizedBox,
        DateTimeWidget(
          date: widget.eventData["date"] ?? "",
          time: widget.eventData["time"] ?? "",
        ),
        LocationVenueWidget(
          venue: widget.eventData["venue"] ?? "",
          location: widget.eventData["address"] ?? "",
        ),
        sizedBox,
        const PaddedWidgetEventScreen(
          child: EventScreenTitleWidget(title: "WHO'S GOING"),
        ),
        SizedBox(
          height: 2.h,
        ),
        const WhosGoing(),
      ],
    );
  }
}

class WhosGoing extends StatelessWidget {
  const WhosGoing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddedWidgetEventScreen(
      child: Stack(
        children: [
          const SizedBox(
            width: 100,
          ),
          ProfileImage(
            imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm3RFDZM21teuCMFYx_AROjt-AzUwDBROFww&usqp=CAU",
            radius: 20.sp,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: ProfileImage(
              imageUrl:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRB-r-33_9ZqU1sAITY2wlJNXYt-qkzsLszA&usqp=CAU",
              radius: 20.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: ProfileImage(
              imageUrl:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPCjXb5kLk4GFjjgcpHIJfruGGZXUctuhtBw&usqp=CAU",
              radius: 20.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: ProfileImage(
              imageUrl:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5THWiBbv_RWTA-v_XImaLNEJj-IMaKUlpVg&usqp=CAU",
              radius: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class DistanceDuration extends StatelessWidget {
  const DistanceDuration({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return PaddedWidgetEventScreen(
      child: Row(
        children: [
          const Icon(
            Icons.directions_walk_rounded,
          ),
          SizedBox(
            width: 2.w,
          ),
          Text(
            data["duration"] ?? "",
          ),
          const Spacer(),
          Image.asset(
            "assets/icons/distance.png",
            height: 5.h,
            width: 5.w,
          ),
          SizedBox(
            width: 2.w,
          ),
          Text(
            data["distance"] ?? "",
          ),
        ],
      ),
    );
  }
}

class LocationVenueWidget extends StatelessWidget {
  const LocationVenueWidget({
    super.key,
    required this.venue,
    required this.location,
  });

  final String venue;
  final String location;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    var lightGradient = [
      Colors.black87.withOpacity(0.8),
      Colors.black12,
    ];
    var darkGradient = [
      Colors.white38,
      Colors.white12,
    ];

    return PaddedWidgetEventScreen(
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            width: 100.w,
            height: 6.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                    MediaQuery.platformBrightnessOf(context) == Brightness.light
                        ? lightGradient
                        : darkGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/placeholder.png",
                  height: 3.h,
                  width: 3.h,
                  color: MediaQuery.platformBrightnessOf(context) ==
                          Brightness.light
                      ? Colors.white
                      : primaryColor,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      venue,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 60.w,
                      child: Text(
                        location,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 10.h,
            width: 18.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  MediaQuery.platformBrightnessOf(context) == Brightness.light
                      ? Colors.black87
                      : Colors.white,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.map_rounded,
              color:
                  MediaQuery.platformBrightnessOf(context) == Brightness.light
                      ? Colors.white
                      : primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({
    super.key,
    required this.date,
    required this.time,
  });

  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    var lightGradient = [
      Colors.black87.withOpacity(0.8),
      Colors.black12,
    ];
    var darkGradient = [
      Colors.white38,
      Colors.white12,
    ];

    return PaddedWidgetEventScreen(
      child: Row(
        children: [
          Container(
            height: 8.h,
            width: 15.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors:
                    MediaQuery.platformBrightnessOf(context) == Brightness.light
                        ? lightGradient
                        : darkGradient,
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
          SizedBox(
            width: 3.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(time),
            ],
          ),
        ],
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
    return PaddedWidgetEventScreen(
      child: ReadMoreText(
        description,
        trimLines: 6,
        colorClickableText: Colors.pink,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'Show more',
        trimExpandedText: 'Show less',
        moreStyle: textStyle(context),
        lessStyle: textStyle(context),
      ),
    );
  }

  TextStyle textStyle(BuildContext context) {
    return TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.bold,
      color: MediaQuery.platformBrightnessOf(context) == Brightness.light
          ? Colors.green
          : const Color.fromARGB(255, 0, 255, 170).withOpacity(0.7),
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
                          ? Colors.black
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

    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? Colors.black
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
            height: 65.h,
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
