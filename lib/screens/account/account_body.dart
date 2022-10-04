import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../dto/const.dart';
import '../../dto/friend_params_dto.dart';
import '../../main.dart';
import '../webview.dart';
import 'app_bar_with_image.dart';
import 'normal_menu.dart';

class AccountBody extends StatefulWidget {
  final AuthBloc authBloc;

  const AccountBody({key, required this.authBloc}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AccountBody();
}

class _AccountBody extends State<AccountBody> {
  @override
  Widget build(BuildContext context) {
    var moneyFormat = new NumberFormat("###,###,###", "vi_VN");
    return CustomScrollView(
      slivers: <Widget>[
        Text('title').tr(),
        AccountAppBarWithImage(user: user),
        SliverToBoxAdapter(
          child: Column(children: <Widget>[
            (Platform.isIOS && !user.enableIosTrans)
                ? SizedBox(height: 0)
                : AccountNormalMenu(
                    title: "Giao dịch của tôi".tr(),
                    route: "/transaction",
                    leadingIcon: MdiIcons.wallet,
                    trailing: Icon(Icons.chevron_right),
                    // subContent: Text(
                    //   "anyPoint: " + moneyFormat.format(user.walletC),
                    //   style: TextStyle(
                    //     color: Colors.orange,
                    //     fontSize: 12.0,
                    //     fontFeatures: [FontFeature.tabularFigures()],
                    //   ),
                    // ),
                  ),
            user.role == MyConst.ROLE_MEMBER
                ? SizedBox(height: 0)
                : AccountNormalMenu(
                    title: "Khóa học của tôi".tr(),
                    route: "/course/list",
                    leadingIcon: MdiIcons.viewList,
                    trailing: Icon(
                      Icons.chevron_right,
                    ),
                  ),
            AccountNormalMenu(
              title: "Lịch học của tôi".tr(),
              route: "/account/calendar",
              leadingIcon: MdiIcons.calendarAccount,
              trailing: Icon(Icons.chevron_right),
            ),

            AccountNormalMenu(
              title: "Danh sách bạn bè".tr(),
              route: "/account/friends",
              routeParam: FriendParamsDTO(userId: user.id, level: 1),
              leadingIcon: MdiIcons.accountGroup,
              trailing: SizedBox(
                  width: 80.0,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(user.numFriends.toString() + " bạn "),
                    Icon(Icons.chevron_right),
                  ])),
            ),
            AccountNormalMenu(
              title: "Quỹ từ thiện".tr(),
              route: "/foundation",
              routeParam: FriendParamsDTO(userId: user.id, level: 1),
              leadingIcon: MdiIcons.piggyBank,
              trailing: Icon(Icons.chevron_right_sharp),
            ),

            AccountNormalMenu(
              title: "Quản lý tài khoản phụ".tr(),
              route: "/account/children",
              routeParam: user,
              leadingIcon: MdiIcons.accountChild,
              trailing: Icon(Icons.chevron_right_sharp),
            ),
            AccountNormalMenu(
              title: "Thông tin cá nhân".tr(),
              route: "/account/edit",
              leadingIcon: Icons.account_box,
              trailing: Icon(Icons.edit),
            ),
            AccountNormalMenu(
              title: "Mã giới thiệu".tr(),
              leadingIcon: MdiIcons.qrcode,
              trailing: Icon(Icons.share),
              subContent: Text(user.refcode + " (chạm để chia sẻ)".tr()),
              routeFunction: () => Share.share(user.refLink),
            ),
            user.role == MyConst.ROLE_TEACHER
                ? AccountNormalMenu(
                    title: "Hợp đồng giảng viên".tr(),
                    route: "/contract/teacher",
                    routeParam: user.token,
                    leadingIcon: MdiIcons.fileCertificateOutline,
                    trailing: Icon(
                      Icons.chevron_right,
                    ),
                  )
                : SizedBox(height: 0),
            user.role == MyConst.ROLE_SCHOOL
                ? AccountNormalMenu(
                    title: "Hợp đồng trường học".tr(),
                    route: "/contract/school",
                    routeParam: user.token,
                    leadingIcon: MdiIcons.fileCertificateOutline,
                    trailing: Icon(
                      Icons.chevron_right,
                    ),
                  )
                : SizedBox(height: 0),
            user.role == MyConst.ROLE_MEMBER
                ? SizedBox(height: 0)
                : AccountNormalMenu(
                    title: "Cập nhật chứng chỉ".tr(),
                    route: "/account/docs",
                    routeParam: user.token,
                    leadingIcon: MdiIcons.certificate,
                    trailing: Icon(
                      Icons.chevron_right,
                    ),
                  ),
            // Navigator.of(context).popUntil(ModalRoute.withName("/"));

            AccountNormalMenu(
              title: "Hướng dẫn sử dụng".tr(),
              route: "/guide",
              routeParam: "guide_" + user.role,
              leadingIcon: MdiIcons.televisionGuide,
              trailing: Icon(Icons.chevron_right),
            ),
            user.role == MyConst.ROLE_SCHOOL ||
                    user.role == MyConst.ROLE_TEACHER
                ? AccountNormalMenu(
                    title: "Chính sách".tr(),
                    route: "/guide",
                    routeParam: "guide_toc_" + user.role,
                    leadingIcon: MdiIcons.notebookOutline,
                    trailing: Icon(Icons.chevron_right),
                  )
                : SizedBox(height: 0),
            AccountNormalMenu(
              title: "Thông tin về anyLEARN.vn".tr(),
              route: "/guide",
              routeParam: MyConst.GUIDE_ABOUT,
              leadingIcon: MdiIcons.information,
              trailing: Icon(Icons.chevron_right),
            ),
            AccountNormalMenu(
              title: "Đổi mật khẩu".tr(),
              route: "/account/password",
              routeParam: user.token,
              leadingIcon: MdiIcons.lock,
              trailing: Icon(Icons.arrow_right),
            ),
            AccountNormalMenu(
              title: "Trung Tâm Hỗ Trợ".tr(),
              routeFunction: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WebviewScreen(
                          url: config.webUrl + "helpcenter",
                        )));
              },
              leadingIcon: MdiIcons.helpCircle,
              trailing: Icon(Icons.chevron_right),
            ),
            AccountNormalMenu(
              title: "Đăng xuất".tr(),
              routeFunction: () {
                widget.authBloc.add(AuthLoggedOutEvent(token: user.token));
              },
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
    // Share.share(text);
  }
}
