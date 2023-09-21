import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../data.dart';

// ignore: must_be_immutable
class LocatorEventDetail extends StatefulWidget {
  LocatorEventDetail({
    super.key,
    required this.sheetPosition,
    required this.getDirection,
  });

  double sheetPosition;
  final Function getDirection;

  @override
  State<LocatorEventDetail> createState() => _LocatorEventDetailState();
}

class _LocatorEventDetailState extends State<LocatorEventDetail> {
  @override
  Widget build(BuildContext context) {
    var data = event[0];

    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;
    var hSizedBox1 = SizedBox(
      height: 0.5.h,
    );
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height - widget.sheetPosition,
      ),
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            widget.sheetPosition += details.delta.dy;
            if (widget.sheetPosition < 0) {
              widget.sheetPosition = 0;
            }
          });
        },
        onVerticalDragEnd: (details) {
          setState(() {
            if (widget.sheetPosition < 150) {
              widget.sheetPosition = 0;
            } else {
              widget.sheetPosition = 300; // Adjust the height as needed
            }
          });
        },
        child: Container(
          height: 32.h,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 1, 36),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        data["imageUrl"][0],
                        height: 15.h,
                        width: 35.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 55.w,
                          child: Text(
                            data["name"] ?? "",
                            softWrap: true,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        hSizedBox1,
                        Text(data["venue"] ?? ""),
                        hSizedBox1,
                        SizedBox(
                          width: 55.w,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 10.sp,
                                foregroundImage: const NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTApbxj4499GJJWMYvKUVnzMUBJBt1b_Aob0A&usqp=CAU",
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              const Text("John Doe"),
                              const Spacer(),
                              Text(
                                data["date"] ?? "",
                                style: TextStyle(
                                  fontSize: 6.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 4.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 55.w,
                        child: FloatingActionButton.extended(
                          backgroundColor: primaryColor,
                          onPressed: () => widget.getDirection(),
                          label: Text(
                            "Get directions",
                            style: TextStyle(
                              color: scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                      FloatingActionButton.extended(
                        onPressed: null,
                        backgroundColor: Colors.grey,
                        label: Row(
                          children: [
                            Icon(
                              Icons.directions_walk_rounded,
                              color: scaffoldBackgroundColor,
                            ),
                            Text(
                              "1hr",
                              style: TextStyle(color: scaffoldBackgroundColor),
                            ),
                          ],
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: scaffoldBackgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
