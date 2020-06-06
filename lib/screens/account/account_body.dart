import 'dart:ui';

import 'package:anylearn/dto/const.dart';
import 'package:anylearn/dto/friend_params_dto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share/share.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../dto/user_dto.dart';
import 'app_bar_with_image.dart';
import 'normal_menu.dart';

class AccountBody extends StatefulWidget {
  final UserDTO user;
  final AuthBloc authBloc;

  const AccountBody({Key key, this.user, this.authBloc}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AccountBody(user);
}

class _AccountBody extends State<AccountBody> {
  final UserDTO user;

  _AccountBody(this.user);

  @override
  Widget build(BuildContext context) {
    var moneyFormat = new NumberFormat("###,###,###", "vi_VN");
    return CustomScrollView(
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
              routeFunction: () => _tabToCopy(user.refLink),
            ),
            AccountNormalMenu(
              title: "Khóa học của tôi",
              route: "/course/list",
              leadingIcon: MdiIcons.viewList,
              trailing: Icon(Icons.arrow_right),
            ),
            AccountNormalMenu(
              title: "Lịch học của tôi",
              route: "/account/calendar",
              leadingIcon: MdiIcons.calendarAccount,
              trailing: Icon(Icons.arrow_right),
            ),
            AccountNormalMenu(
                title: "Giao dịch của tôi",
                route: "/transaction",
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
              routeParam: FriendParamsDTO(userId: user.id, level: 1),
              leadingIcon: MdiIcons.accountGroup,
              trailing: SizedBox(
                  width: 80.0,
                  child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    // Text(user.numFriends.toString() + " bạn "),
                    Icon(Icons.arrow_right),
                  ])),
            ),
            AccountNormalMenu(
              title: "Hướng dẫn sử dụng",
              route: "/guide",
              routeParam: "guide_" + user.role,
              leadingIcon: MdiIcons.televisionGuide,
              trailing: Icon(Icons.arrow_right),
            ),
            user.role == MyConst.ROLE_SCHOOL || user.role == MyConst.ROLE_TEACHER
                ? AccountNormalMenu(
                    title: "Chính sách",
                    route: "/guide",
                    routeParam: "guide_toc_" + user.role,
                    leadingIcon: MdiIcons.televisionGuide,
                    trailing: Icon(Icons.arrow_right),
                  )
                : SizedBox(height: 0),
            // AccountNormalMenu(
            //   title: "Gửi phản hồi về ứng dụng",
            //   route: "/account/contact",
            //   leadingIcon: MdiIcons.comment,
            //   trailing: Icon(Icons.arrow_right),
            // ),
            AccountNormalMenu(
              title: "Thông tin về anyLEARN.vn",
              route: "/guide",
              routeParam: MyConst.GUIDE_ABOUT,
              leadingIcon: MdiIcons.information,
              trailing: Icon(Icons.arrow_right),
            ),
            // AccountNormalMenu(
            //   title: "Đổi mật khẩu",
            //   route: "/account/password",
            //   leadingIcon: MdiIcons.lock,
            //   trailing: Icon(Icons.arrow_right),
            // ),
            AccountNormalMenu(
              title: "Đăng xuất",
              routeFunction: () {
                // Navigator.of(context).popUntil(ModalRoute.withName("/"));
                widget.authBloc.add(AuthLoggedOutEvent());
              },
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
    );
  }

  void _tabToCopy(String text) {
    // Clipboard.setData(new ClipboardData(text: text));
    Share.share(text);
  }
}
