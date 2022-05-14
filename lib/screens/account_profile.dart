import 'package:anylearn/main.dart';
import 'package:anylearn/widgets/bottom_nav.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../blocs/account/account_blocs.dart';
import '../customs/custom_cached_image.dart';
import '../dto/const.dart';
import '../dto/hot_items_dto.dart';
import '../dto/user_dto.dart';
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
          user = state.user;
          return Scaffold(
            appBar: AppBar(
              actions: [
                // IconButton(
                //     icon: Icon(Icons.menu),
                //     onPressed: () {
                //       Navigator.of(context).pushNamed("/account");
                //     })
              ],
            ),
            floatingActionButton: FloatingActionButtonHome(),
            floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
            bottomNavigationBar: BottomNav(
              route: BottomNav.PROFILE_INDEX,
              user: user,
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
                  user.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                user.role != MyConst.ROLE_SCHOOL
                    ? Text(
                        user.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(),
                      )
                    : SizedBox(height: 0),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(user.introduce,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: Colors.blue,
                      )),
                ),
                user.role == MyConst.ROLE_SCHOOL && user.title != ""
                    ?
                    // Container(
                    //     padding: EdgeInsets.only(left: 15, right: 15),
                    //     child: Text.rich(TextSpan(text: "Người đại diện: ", children: [TextSpan(text: user!.title)])))
                    ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 15, right: 15),
                        leading: Icon(MdiIcons.shieldAccount),
                        title: Text("Người đại diện: " + user.title),
                        isThreeLine: false,
                      )
                    : SizedBox(height: 0),
                user.address != ""
                    ? ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 15, right: 15),
                        leading: Icon(MdiIcons.mapMarker),
                        title: Text(user.address),
                        isThreeLine: false,
                      )
                    : SizedBox(height: 0),
                user.docs == null || user.docs.length == 0
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
                            ),
                          )
                        ],
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: user.docs == null || user.docs.length == 0
                      ? SizedBox(height: 0)
                      : UserDocList(userDocs: user.docs),
                ),
                (user.registered == null || user.registered.length == 0)
                    ? SizedBox(height: 0)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Divider(
                          //   thickness: 10,
                          // ),
                          HotItems(
                            hotItems: [HotItemsDTO(title: "Các khoá học đã đăng ký", list: user.registered)],
                          ),
                        ],
                      ),
                (user.faved == null || user.faved.length == 0)
                    ? SizedBox(height: 0)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Divider(
                          //   thickness: 10,
                          // ),
                          HotItems(
                            hotItems: [HotItemsDTO(title: "Các khoá học đang quan tâm", list: user.faved)],
                          ),
                        ],
                      ),
                (user.rated == null || user.rated.length == 0)
                    ? SizedBox(height: 0)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Divider(
                          //   thickness: 10,
                          // ),
                          HotItems(
                            hotItems: [HotItemsDTO(title: "Các khoá học đã đánh giá", list: user.rated)],
                          ),
                        ],
                      ),
                user.fullContent == ""
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
                              data: user.fullContent,
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
            child: (user.image != "")
                ? CircleAvatar(radius: size / 2 - 2.0, backgroundImage: CachedNetworkImageProvider(user.image))
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
      child: user.banner != "" ? CustomCachedImage(url: user.banner) : SizedBox(height: size),
    );
  }
}
