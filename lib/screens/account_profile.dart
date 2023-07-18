import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/main.dart';
import 'package:anylearn/widgets/bottom_nav.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../blocs/account/account_bloc.dart';
import '../customs/custom_cached_image.dart';
import '../dto/const.dart';
import '../dto/hot_items_dto.dart';
import '../models/user_repo.dart';
import '../widgets/fab_home.dart';
import '../widgets/hot_items.dart';
import '../widgets/loading_widget.dart';
import 'account/user_doc_list.dart';
import 'webview.dart';

class AccountProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountProfileScreen();
}

class _AccountProfileScreen extends State<AccountProfileScreen> {
  late AccountBloc _accountBloc;
  UserDTO? userProfile;

  @override
  void didChangeDependencies() {
    final _userRepo = RepositoryProvider.of<UserRepository>(context);
    _accountBloc = AccountBloc(userRepository: _userRepo);
    int userId = 0;
    try {
      userId = int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    } catch (e) {
      if (user.id > 0) {
        userId = user.id;
      }
    }

    if (userId == 0) {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        Navigator.of(context).pop();
      });
    } else {
      _accountBloc..add(AccProfileEvent(userId: userId));
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<AccountBloc, AccountState>(
      bloc: _accountBloc,
      builder: (context, state) {
        if (state is AccProfileSuccessState) {
          userProfile = state.user;
          return Scaffold(
            appBar: AppBar(
              actions: [],
            ),
            floatingActionButton: FloatingActionButtonHome(),
            floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
            bottomNavigationBar: BottomNav(
              BottomNav.ACCOUNT_INDEX,
            ),
            body: ListView(
              children: [
                Stack(
                  children: [
                    _bannerBox(width / 2),
                    _imageBox(width / 3),
                  ],
                ),
                Text(
                  userProfile!.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                userProfile!.role != MyConst.ROLE_SCHOOL
                    ? Text(
                        userProfile!.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(),
                      )
                    : SizedBox(height: 0),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(userProfile!.introduce,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: Colors.blue,
                      )),
                ),
                userProfile!.role == MyConst.ROLE_SCHOOL && userProfile!.title != ""
                    ?
                    // Container(
                    //     padding: EdgeInsets.only(left: 15, right: 15),
                    //     child: Text.rich(TextSpan(text: "Người đại diện: ", children: [TextSpan(text: user!.title)])))
                    ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 15, right: 15),
                        leading: Icon(MdiIcons.shieldAccount),
                        title: Text("Người đại diện: " + userProfile!.title).tr(),
                        isThreeLine: false,
                      )
                    : SizedBox(height: 0),
                userProfile!.address != ""
                    ? ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 15, right: 15),
                        leading: Icon(MdiIcons.mapMarker),
                        title: Text(userProfile!.address),
                        isThreeLine: false,
                      )
                    : SizedBox(height: 0),
                userProfile!.docs == null || userProfile!.docs.length == 0
                    ? SizedBox(height: 0)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              "Chứng chỉ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ).tr(),
                          )
                        ],
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: userProfile!.docs == null || userProfile!.docs.length == 0
                      ? SizedBox(height: 0)
                      : UserDocList(userDocs: userProfile!.docs),
                ),
                (userProfile!.registered == null || userProfile!.registered.length == 0)
                    ? SizedBox(height: 0)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Divider(
                          //   thickness: 10,
                          // ),
                          HotItems(
                            hotItems: [
                              HotItemsDTO(title: "Các khoá học đã đăng ký".tr(), list: userProfile!.registered)
                            ],
                          ),
                        ],
                      ),
                (userProfile!.faved == null || userProfile!.faved.length == 0)
                    ? SizedBox(height: 0)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Divider(
                          //   thickness: 10,
                          // ),
                          HotItems(
                            hotItems: [HotItemsDTO(title: "Các khoá học đang quan tâm".tr(), list: userProfile!.faved)],
                          ),
                        ],
                      ),
                (userProfile!.rated == null || userProfile!.rated.length == 0)
                    ? SizedBox(height: 0)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Divider(
                          //   thickness: 10,
                          // ),
                          HotItems(
                            hotItems: [HotItemsDTO(title: "Các khoá học đã đánh giá".tr(), list: userProfile!.rated)],
                          ),
                        ],
                      ),
                userProfile!.fullContent == ""
                    ? SizedBox(height: 0)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            thickness: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Html(
                              data: userProfile!.fullContent,
                              shrinkWrap: true,
                              onLinkTap: (url, _, __, ___) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => WebviewScreen(
                                          url: url!,
                                        )));
                              },
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          );
        }
        return LoadingWidget();
      },
    );
  }

  Widget _imageBox(double size) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: size, left: size, right: size),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: size / 2,
            child: (userProfile!.image != "")
                ? CircleAvatar(radius: size / 2 - 2.0, backgroundImage: CachedNetworkImageProvider(userProfile!.image))
                : Icon(
                    Icons.account_circle,
                    size: size,
                    color: Colors.grey,
                  ),
          ),
        ),
      ],
    );
  }

  Widget _bannerBox(double size) {
    return Container(
      height: size,
      width: double.infinity,
      alignment: Alignment.bottomRight,
      color: Colors.grey[200],
      child: userProfile!.banner != "" ? CustomCachedImage(url: userProfile!.banner) : SizedBox(height: size),
    );
  }
}
