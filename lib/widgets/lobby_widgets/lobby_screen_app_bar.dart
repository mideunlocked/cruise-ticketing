import 'package:cruise/screens/event_screens/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/distance_duration_helper.dart';
import '../../models/event.dart';
import '../../providers/users_provider.dart';
import '../../screens/lobby_screens/lobby_screen.dart';

class LobbyScreenAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  const LobbyScreenAppBar({
    super.key,
    required this.widget,
  });

  final LobbyScreen widget;

  @override
  State<LobbyScreenAppBar> createState() => _LobbyScreenAppBarState();
}

class _LobbyScreenAppBarState extends State<LobbyScreenAppBar> {
  Map<String, dynamic> durationData = {};
  Event? event;

  @override
  void initState() {
    super.initState();

    event = widget.widget.event;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final eventLatLng = event?.geoPoint;

    durationData = await DistanceAndDuration.getDistanceDuration(
      eventLatLng?.latitude ?? 0.0,
      eventLatLng?.longitude ?? 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UsersProvider>(context);

    return AppBar(
      centerTitle: false,
      leading: IconButton(
        onPressed: () => Navigator.of(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
        ),
      ),
      title: Text(widget.widget.event.name),
      actions: [
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => FutureBuilder(
                      future: userProvider.getUser(widget.widget.event.hostId),
                      builder: (context, snapshot) {
                        return EventScreen(
                          durationData: durationData,
                          event: widget.widget.event,
                          host: snapshot.data,
                        );
                      },
                    )),
          ),
          child: CircleAvatar(
            radius: 13.sp,
            foregroundImage: NetworkImage(
              widget.widget.event.imageUrl,
            ),
          ),
        ),
        SizedBox(
          width: 1.w,
        ),
      ],
    );
  }
}
