import 'package:cruise/data.dart';
import 'package:cruise/widgets/home_screen_widgets/event_today_tile.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/search_widgets/search_widget.dart';

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
