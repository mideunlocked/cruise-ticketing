import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SaveEventButton extends StatelessWidget {
  const SaveEventButton({
    super.key,
    required this.isSaved,
    required this.left,
    required this.top,
  });

  final bool isSaved;
  final double left;
  final double top;

  @override
  Widget build(BuildContext context) {
    // var of = Theme.of(context);
    // var primaryColor = of.primaryColor;

    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    var checkSave = isSaved == true;

    return Positioned(
      left: left,
      top: top,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 4.h,
          width: 10.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              colors: [Colors.black45, Colors.black12],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          alignment: Alignment.center,
          child: Icon(
            checkSave ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
