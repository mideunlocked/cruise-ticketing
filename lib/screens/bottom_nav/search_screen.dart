import 'package:cruise/data.dart';
import 'package:cruise/widgets/home_screen_widgets/event_today_tile.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  FocusNode node = FocusNode();

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
    node.dispose();
  }

  dynamic searchResult;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.h,
          ),
          SearchWidget(
            primaryColor: primaryColor,
            controller: controller,
            node: node,
            bodyMedium: bodyMedium,
          ),
          SizedBox(
            height: 1.h,
          ),
          const Divider(
            color: Colors.white24,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  EventListTile(
                    data: event.first,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.primaryColor,
    required this.controller,
    required this.node,
    required this.bodyMedium,
  });

  final Color primaryColor;
  final TextEditingController controller;
  final FocusNode node;
  final TextStyle? bodyMedium;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryColor.withOpacity(0.1),
      ),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        focusNode: node,
        textInputAction: TextInputAction.search,
        cursorColor: primaryColor,
        style: bodyMedium?.copyWith(
          fontSize: 10.sp,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          hintText: "Search",
          hintStyle: bodyMedium?.copyWith(
            fontSize: 10.sp,
            color: Colors.white24,
          ),
          prefixIcon: Row(
            children: [
              TextFieldIcon(node: node, iconUrl: "assets/icons/search.png"),
            ],
          ),
          suffixIcon: InkWell(
            onTap: () {
              controller.clear();
            },
            child: TextFieldIcon(node: node, iconUrl: "assets/icons/close.png"),
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 5.h,
            maxWidth: 8.w,
          ),
          suffixIconConstraints: BoxConstraints(
            maxHeight: 3.h,
            maxWidth: 3.w,
          ),
        ),
      ),
    );
  }
}

class TextFieldIcon extends StatelessWidget {
  const TextFieldIcon({
    super.key,
    required this.node,
    required this.iconUrl,
  });

  final FocusNode node;
  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      iconUrl,
      height: 5.h,
      width: 5.w,
      color: node.hasFocus ? Colors.white30 : Colors.white,
    );
  }
}
