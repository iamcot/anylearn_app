import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share/share.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../dto/const.dart';
import '../../dto/friend_params_dto.dart';
import '../../dto/user_dto.dart';
import 'app_bar_with_image.dart';
import 'normal_menu.dart';

class AccountBody extends StatefulWidget {
  final UserDTO user;
  final AuthBloc authBloc;

  const AccountBody({Key key, this.user, this.authBloc}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AccountBody();
}

class _AccountBody extends State<AccountBody> {
  @override
  Widget build(BuildContext context) {
    var moneyFormat = new NumberFormat("###,###,###", "vi_VN");
    return CustomScrollView(
      slivers: <Widget>[
        AccountAppBarWithImage(user: widget.user),
        SliverToBoxAdapter(
          child: Column(children: <Widget>[
            (Platform.isIOS && !widget.user.enableIosTrans)
                ? SizedBox(height: 0)
                : AccountNormalMenu(
                    title: "Giao dịch của tôi",
                    route: "/transaction",
                    leadingIcon: MdiIcons.wallet,
                    trailing: Icon(Icons.chevron_right),
                    subContent: Text.rich(
                      TextSpan(
                          text: "TK tiền: " + moneyFormat.format(widget.user.walletM),
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
                              text: "TK điểm: " + moneyFormat.format(widget.user.walletC),
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 12.0,
                                fontFeatures: [FontFeature.tabularFigures()],
                              ),
                            )
                          ]),
                    )),
            widget.user.role == MyConst.ROLE_MEMBER
                ? SizedBox(height: 0)
                : AccountNormalMenu(
                    title: "Khóa học của tôi",
                    route: "/course/list",
                    leadingIcon: MdiIcons.viewList,
                    trailing: Icon(
                      Icons.chevron_right,
                    ),
                  ),
            AccountNormalMenu(
              title: "Lịch học của tôi",
              route: "/account/calendar",
              leadingIcon: MdiIcons.calendarAccount,
              trailing: Icon(Icons.chevron_right),
            ),

            AccountNormalMenu(
              title: "Danh sách bạn bè",
              route: "/account/friends",
              routeParam: FriendParamsDTO(userId: widget.user.id, level: 1),
              leadingIcon: MdiIcons.accountGroup,
              trailing: SizedBox(
                  width: 80.0,
                  child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(widget.user.numFriends.toString() + " bạn "),
                    Icon(Icons.chevron_right),
                  ])),
            ),
            AccountNormalMenu(
              title: "Thông tin cá nhân",
              route: "/account/edit",
              leadingIcon: Icons.account_box,
              trailing: Icon(Icons.edit),
            ),
            AccountNormalMenu(
              title: "Mã giới thiệu",
              leadingIcon: MdiIcons.qrcode,
              trailing: Icon(Icons.share),
              subContent: Text(widget.user.refcode + " (chạm để chia sẻ)"),
              routeFunction: () => _tabToCopy(widget.user.refLink),
            ),
            widget.user.role == MyConst.ROLE_TEACHER
                ? AccountNormalMenu(
                    title: "Hợp đồng giảng viên",
                    route: "/contract/teacher",
                    routeParam: widget.user.token,
                    leadingIcon: MdiIcons.fileCertificateOutline,
                    trailing: Icon(
                      Icons.chevron_right,
                    ),
                  )
                : SizedBox(height: 0),
            widget.user.role == MyConst.ROLE_SCHOOL
                ? AccountNormalMenu(
                    title: "Hợp đồng trường học",
                    route: "/contract/school",
                    routeParam: widget.user.token,
                    leadingIcon: MdiIcons.fileCertificateOutline,
                    trailing: Icon(
                      Icons.chevron_right,
                    ),
                  )
                : SizedBox(height: 0),
            widget.user.role == MyConst.ROLE_MEMBER
                ? SizedBox(height: 0)
                : AccountNormalMenu(
                    title: "Cập nhật chứng chỉ",
                    route: "/account/docs",
                    routeParam: widget.user.token,
                    leadingIcon: MdiIcons.certificate,
                    trailing: Icon(
                      Icons.chevron_right,
                    ),
                  ),
            // Navigator.of(context).popUntil(ModalRoute.withName("/"));

            AccountNormalMenu(
              title: "Hướng dẫn sử dụng",
              route: "/guide",
              routeParam: "guide_" + widget.user.role,
              leadingIcon: MdiIcons.televisionGuide,
              trailing: Icon(Icons.chevron_right),
            ),
            widget.user.role == MyConst.ROLE_SCHOOL || widget.user.role == MyConst.ROLE_TEACHER
                ? AccountNormalMenu(
                    title: "Chính sách",
                    route: "/guide",
                    routeParam: "guide_toc_" + widget.user.role,
                    leadingIcon: MdiIcons.notebookOutline,
                    trailing: Icon(Icons.chevron_right),
                  )
                : SizedBox(height: 0),
            AccountNormalMenu(
              title: "Thông tin về anyLEARN.vn",
              route: "/guide",
              routeParam: MyConst.GUIDE_ABOUT,
              leadingIcon: MdiIcons.information,
              trailing: Icon(Icons.chevron_right),
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
                widget.authBloc.add(AuthLoggedOutEvent(token: widget.user.token));
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
