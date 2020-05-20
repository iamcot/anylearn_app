import 'dart:ui';

import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/screens/account/normal_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountScreen();
}

class _AccountScreen extends State<AccountScreen> {
  final UserDTO user = new UserDTO(
    name: "MC Hoài Trinh",
    refcode: "1900113",
    walletC: 100,
    walletM: 123400,
    // image: "",
    image:
        "https://scontent.fvca1-2.fna.fbcdn.net/v/t1.0-9/89712877_1076973919331440_3222915485796401152_n.jpg?_nc_cat=107&_nc_sid=7aed08&_nc_ohc=d-jXcHVpNOEAX8IU-ED&_nc_ht=scontent.fvca1-2.fna&oh=f98801f09d0720e77e524fef83f6e472&oe=5EEA3ECF",
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double barHeight = width * 3 / 5;
    var moneyFormat = new NumberFormat("###,###,###", "vi_VN");
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: user.image.isNotEmpty ? barHeight : 0,
            centerTitle: true,
            floating: true,
            pinned: user.image.isNotEmpty ? false : true,
            actions: <Widget>[IconButton(icon: Icon(MdiIcons.qrcodeScan), onPressed: () {
              Navigator.of(context).pushNamed("/qrcode");
            })],
            flexibleSpace: LayoutBuilder(
              builder: (context, bc) {
                return FlexibleSpaceBar(
                  centerTitle: false,
                  title: Container(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    decoration: user.image.isNotEmpty
                        ? BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            color: Colors.black38,
                          )
                        : null,
                    child: Text(
                      user.name,
                      style: TextStyle(),
                    ),
                  ),
                  background: new ClipRect(
                    child: new Container(
                      decoration: new BoxDecoration(
                        image: user.image.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(user.image), fit: BoxFit.cover, alignment: Alignment.topCenter)
                            : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(children: <Widget>[
              AccountNormalMenu(
                title: "Thông tin cá nhân",
                route: "/account/info",
                leadingIcon: Icons.account_box,
                trailingIcon: Icons.edit,
              ),
              AccountNormalMenu(
                title: "Mã giới thiệu",
                leadingIcon: MdiIcons.qrcode,
                trailingIcon: Icons.content_copy,
                subContent: Text(user.refcode + " (chạm để copy)"),
                routeFunction: () => _tabToCopy(user.refcode),
                routeFunctionMsg: "Đã chép Mã giới thiệu",
              ),
              AccountNormalMenu(
                title: "Lịch học của tôi",
                route: "/account/schedule",
                leadingIcon: MdiIcons.calendarAccount,
                trailingIcon: Icons.arrow_right,
              ),
              AccountNormalMenu(
                title: "Giao dịch của tôi",
                route: "/account/transaction",
                leadingIcon: MdiIcons.wallet,
                trailingIcon: Icons.arrow_right,
                subContent: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Ví tiền: " + moneyFormat.format(user.walletM),
                    style: TextStyle(
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                  Text("Ví điểm: " + moneyFormat.format(user.walletC),
                    style: TextStyle(
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),),
                ]),
              ),
              AccountNormalMenu(
                title: "Danh sách bạn bè",
                route: "/account/friends",
                leadingIcon: MdiIcons.accountGroup,
                trailingIcon: Icons.arrow_right,
              ),
              AccountNormalMenu(
                title: "Hướng dẫn sử dụng",
                route: "/account/helpcenter",
                leadingIcon: MdiIcons.televisionGuide,
                trailingIcon: Icons.arrow_right,
              ),
              AccountNormalMenu(
                title: "Gửi phản hồi về ứng dụng",
                route: "/account/feedback",
                leadingIcon: MdiIcons.comment,
                trailingIcon: Icons.arrow_right,
              ),
              AccountNormalMenu(
                title: "Thông tin liên hệ công ty",
                route: "/account/contact",
                leadingIcon: MdiIcons.officeBuilding,
                trailingIcon: Icons.arrow_right,
              ),
              AccountNormalMenu(
                title: "Đăng xuất",
                route: "/account/logout",
                leadingIcon: null,
                trailingIcon: MdiIcons.logout,
                titleColor: Colors.red,
                trailingColor: Colors.red,
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _tabToCopy(String text) {
    Clipboard.setData(new ClipboardData(text: text));
  }
}
