import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/event_provider.dart';

class SaveEventButton extends StatefulWidget {
  const SaveEventButton({
    super.key,
    required this.isSaved,
    required this.left,
    required this.top,
    required this.eventId,
  });

  final bool isSaved;
  final String eventId;
  final double left;
  final double top;

  @override
  State<SaveEventButton> createState() => _SaveEventButtonState();
}

class _SaveEventButtonState extends State<SaveEventButton> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();

    isSaved = widget.isSaved;
  }

  @override
  Widget build(BuildContext context) {
    // var of = Theme.of(context);
    // var primaryColor = of.primaryColor;

    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return Positioned(
      left: widget.left,
      top: widget.top,
      child: InkWell(
        onTap: toggleSave,
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
            isSaved ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void toggleSave() {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);

    setState(() {
      isSaved = !isSaved;
    });

    !isSaved
        ? eventProvider.unsaveEvent(widget.eventId)
        : eventProvider.saveEvent(widget.eventId);
  }
}
