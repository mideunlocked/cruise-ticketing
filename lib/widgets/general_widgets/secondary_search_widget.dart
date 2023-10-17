import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../search_widgets/text_field_icon.dart';

class SecondarySearchWidget extends StatefulWidget {
  const SecondarySearchWidget({
    super.key,
    required this.passSearchQuery,
    this.hint = "Search",
  });

  final Function(String) passSearchQuery;
  final String hint;

  @override
  State<SecondarySearchWidget> createState() => _AttendeeSearchWidgetState();
}

class _AttendeeSearchWidgetState extends State<SecondarySearchWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var customOutlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    );

    return Padding(
      padding: EdgeInsets.only(
        left: 3.w,
        right: 3.w,
        bottom: 2.h,
      ),
      child: TextField(
        controller: controller,
        style: Theme.of(context).textTheme.bodyMedium,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.only(left: 3.w),
          hintText: widget.hint,
          border: customOutlineBorder,
          enabledBorder: customOutlineBorder,
          focusedBorder: customOutlineBorder,
          suffixIcon: !FocusScope.of(context).hasFocus
              ? const SizedBox()
              : InkWell(
                  onTap: () {
                    controller.clear();
                    widget.passSearchQuery("");
                    FocusScope.of(context).unfocus();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 3.w),
                    child:
                        const TextFieldIcon(iconUrl: "assets/icons/close.png"),
                  ),
                ),
          suffixIconConstraints: BoxConstraints(
            maxHeight: 3.h,
            maxWidth: 3.h,
          ),
        ),
        onChanged: (value) {
          widget.passSearchQuery(value);
        },
        onSubmitted: (value) {
          widget.passSearchQuery(value);
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
