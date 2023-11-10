import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/message.dart';
import '../../models/users.dart';
import '../../providers/users_provider.dart';

class ViewImageSheet extends StatelessWidget {
  const ViewImageSheet({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

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
              FutureBuilder(
                  future: userProvider.getUser(message.userId),
                  builder: (context, AsyncSnapshot<Users> snapshot) {
                    Users user = snapshot.data as Users;

                    return Text(
                      "Photo sent by ${user.username}",
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    );
                  }),
            ],
          ),
          Expanded(
            child: Image.network(
              message.fileLink,
            ),
          ),
        ],
      ),
    );
  }
}
