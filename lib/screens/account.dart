import 'dart:ui';

import '../dto/user_dto.dart';
import 'account/app_bar_with_image.dart';
import 'account/normal_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share/share.dart';

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
    numFriends: 99,
    // image: "",
    image:
        "https://scontent.fvca1-2.fna.fbcdn.net/v/t1.0-9/89712877_1076973919331440_3222915485796401152_n.jpg?_nc_cat=107&_nc_sid=7aed08&_nc_ohc=d-jXcHVpNOEAX8IU-ED&_nc_ht=scontent.fvca1-2.fna&oh=f98801f09d0720e77e524fef83f6e472&oe=5EEA3ECF",
  );

  @override
  Widget build(BuildContext context) {
    var moneyFormat = new NumberFormat("###,###,###", "vi_VN");
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          AccountAppBarWithImage(user: user),
          SliverToBoxAdapter(
            child: Column(children: <Widget>[
              AccountNormalMenu(
                title: "Thông tin cá nhân",
                route: "/account/edit",
                leadingIcon: Icons.account_box,
                trailing: Icon(Icons.edit),
              ),
              AccountNormalMenu(
                title: "Mã giới thiệu",
                leadingIcon: MdiIcons.qrcode,
                trailing: Icon(Icons.content_copy),
                subContent: Text(user.refcode + " (chạm để chia sẻ)"),
                routeFunction: () => _tabToCopy(user.refcode),
              ),
              AccountNormalMenu(
                title: "Lịch học của tôi",
                route: "/account/calendar",
                leadingIcon: MdiIcons.calendarAccount,
                trailing: Icon(Icons.arrow_right),
              ),
              AccountNormalMenu(
                  title: "Giao dịch của tôi",
                  route: "/account/transaction",
                  leadingIcon: MdiIcons.wallet,
                  trailing: Icon(Icons.arrow_right),
                  subContent: Text.rich(
                    TextSpan(
                        text: "Ví tiền: " + moneyFormat.format(user.walletM),
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12.0,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                        children: [
                          TextSpan(
                            text: " | ",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          TextSpan(
                            text: "Ví điểm: " + moneyFormat.format(user.walletC),
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 12.0,
                              fontFeatures: [FontFeature.tabularFigures()],
                            ),
                          )
                        ]),
                  )),
              AccountNormalMenu(
                title: "Danh sách bạn bè",
                route: "/account/friends",
                leadingIcon: MdiIcons.accountGroup,
                trailing: SizedBox(
                    width: 80.0,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Text(user.numFriends.toString() + " bạn "),
                      Icon(Icons.arrow_right),
                    ])),
              ),
              AccountNormalMenu(
                title: "Hướng dẫn sử dụng",
                route: "/account/helpcenter",
                leadingIcon: MdiIcons.televisionGuide,
                trailing: Icon(Icons.arrow_right),
              ),
              AccountNormalMenu(
                title: "Gửi phản hồi về ứng dụng",
                route: "/account/contact",
                leadingIcon: MdiIcons.comment,
                trailing: Icon(Icons.arrow_right),
              ),
              AccountNormalMenu(
                title: "Thông tin về anyLEARN.vn",
                route: "/account/about",
                leadingIcon: MdiIcons.officeBuilding,
                trailing: Icon(Icons.arrow_right),
              ),
              AccountNormalMenu(
                title: "Đổi mật khẩu",
                route: "/account/password",
                leadingIcon: MdiIcons.formTextboxPassword,
                trailing: Icon(Icons.arrow_right),
              ),
              AccountNormalMenu(
                title: "Đăng xuất",
                route: "/account/logout",
                leadingIcon: null,
                trailing: Icon(
                  MdiIcons.logout,
                  color: Colors.red,
                ),
                titleColor: Colors.red,
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _tabToCopy(String text) {
    // Clipboard.setData(new ClipboardData(text: text));
    Share.share(text);
  }
}
