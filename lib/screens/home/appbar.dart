import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/screens/home/wallet_card.dart';
import 'package:anylearn/widgets/account_icon.dart';
import 'package:anylearn/widgets/add_course_icon.dart';
import 'package:anylearn/widgets/notification_icon.dart';
import 'package:anylearn/widgets/search_icon.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final UserDTO user;

  const HomeAppBar({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double statusHeight = MediaQuery.of(context).padding.top;//iOS = 44 & Android = 22
    return SliverAppBar(
      expandedHeight: 185 - (statusHeight - 24),
      title: Image.asset(
        "assets/images/logo.png",
        height: 24.0,
      ),
      centerTitle: false,
      floating: false,
      pinned: true,
      actions: <Widget>[
        AddCourseIcon(),
        SearchIcon(),
        NotificationIcon(),
        AccountIcon(userAvatar: user.image,),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (context, bc) {
          return FlexibleSpaceBar(
            centerTitle: false,
            background: new ClipRect(
              child: new Container(
                child: Container(margin: EdgeInsets.fromLTRB(30.0, 90.0, 30.0, 5.0), child: WalletCard()),
                decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/bg.png",
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}