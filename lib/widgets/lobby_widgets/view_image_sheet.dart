import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ViewImageSheet extends StatelessWidget {
  const ViewImageSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            height: 3.h,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              const Text(
                "Photo sent by username",
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Expanded(
            child: Image.network(
              "https://images.pexels.com/photos/2147029/pexels-photo-2147029.jpeg?auto=compress&cs=tinysrgb&w=600",
            ),
          ),
        ],
      ),
    );
  }
}
