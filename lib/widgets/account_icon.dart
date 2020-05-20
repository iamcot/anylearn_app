import 'package:flutter/material.dart';

class AccountIcon extends StatelessWidget {
  final String userAvatar;

  const AccountIcon({Key key, this.userAvatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      child: IconButton(
          icon: userAvatar == null || userAvatar.isEmpty
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
                      userAvatar,
                    ),
                  ),
                ),
          onPressed: () {
            Navigator.of(context).pushNamed("/account");
          }),
    );
  }
}
