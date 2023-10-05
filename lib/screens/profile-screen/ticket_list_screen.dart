import 'package:cruise/data.dart';
import 'package:cruise/widgets/general_widgets/custom_app_bar.dart';
import 'package:cruise/widgets/home_screen_widgets/home_screen_padding.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TicketListScreen extends StatelessWidget {
  static const routeName = "/TicketListScreen";

  const TicketListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(
      height: 1.h,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            sizedBox,
            const HomeScreenPadding(
              child: CustomAppBar(
                title: "Tickets",
                bottomPadding: 0,
              ),
            ),
            const Divider(
              color: Colors.black12,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: event.length,
                  itemBuilder: (ctx, index) {
                    var data = event[index];
                    return TicketListTile(
                      data: data,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketListTile extends StatelessWidget {
  const TicketListTile({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    var isValid = data["isValid"] == true;

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        "/TicketScreen",
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 1.h,
          horizontal: 3.w,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                data["imageUrl"],
                width: 30.w,
                height: 10.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60.w,
                  child: Text(
                    data["name"],
                    style: bodyMedium?.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${data["pricing"][0]['category']}: ",
                      style: bodyMedium,
                    ),
                    Text(
                      data["pricing"][0]['price'],
                      style: bodyMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Status: ",
                      style: bodyMedium?.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      isValid ? "Valid" : "Expired",
                      style: bodyMedium?.copyWith(
                        color: isValid ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
