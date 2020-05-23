import 'package:flutter/material.dart';

import '../dto/user_dto.dart';

class AccountIcon extends StatelessWidget {
  final UserDTO user;
  const AccountIcon({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      child: IconButton(
          icon: user == null || user.image.isEmpty
              ? Icon(
                  Icons.account_circle,
                  size: 32.0,
                )
              : CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                      user.image,
                    ),
                  ),
                ),
          onPressed: () {
            Navigator.of(context).pushNamed("/account");
            // Navigator.of(context).pushNamed(user != null ? "/account" : "/login");
          }),
    );
  }
}
