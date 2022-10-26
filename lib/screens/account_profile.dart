import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../blocs/account/account_blocs.dart';
import '../customs/custom_cached_image.dart';
import '../dto/const.dart';
import '../dto/profile/post_dto.dart';
import '../dto/profile/profile_dto.dart';
import '../main.dart';
import '../models/user_repo.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fab_home.dart';
import '../widgets/loading_widget.dart';
import '../widgets/postcard.dart';
import '../widgets/statusSection.dart';
import 'webview.dart';

class AccountProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountProfileScreen();
}

class _AccountProfileScreen extends State<AccountProfileScreen> {
  late AccountBloc _accountBloc;
  ProfileDTO? userProfile;

  @override
  void didChangeDependencies() {
    final _userRepo = RepositoryProvider.of<UserRepository>(context);
    _accountBloc = AccountBloc(userRepository: _userRepo);
    int userId = 0;
    // int postId = 0;
    try {
      userId = int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    } catch (e) {
      if (user.id > 0) {
        userId = user.id;
      }
    }

    if (userId == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
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
          userProfile = state.data;

          return Scaffold(
            appBar: AppBar(
              actions: [],
            ),
            floatingActionButton: FloatingActionButtonHome(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startDocked,
            bottomNavigationBar: BottomNav(
              route: BottomNav.PROFILE_INDEX,
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
                  userProfile!.profile.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                userProfile!.profile.role != MyConst.ROLE_SCHOOL
                    ? Text(
                        userProfile!.profile.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(),
                      )
                    : SizedBox(height: 0),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(userProfile!.profile.introduce,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: Colors.blue,
                      )),
                ),
                userProfile!.profile.role == MyConst.ROLE_SCHOOL &&
                        userProfile!.profile.title != ""
                    ?
                    // Container(
                    //     padding: EdgeInsets.only(left: 15, right: 15),
                    //     child: Text.rich(TextSpan(text: "Người đại diện: ", children: [TextSpan(text: user!.title)])))
                    ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(
                            top: 0, bottom: 0, left: 15, right: 15),
                        leading: Icon(MdiIcons.shieldAccount),
                        title: Text(
                                "Người đại diện: " + userProfile!.profile.title)
                            .tr(),
                        isThreeLine: false,
                      )
                    : SizedBox(height: 0),
                userProfile!.profile.address != ""
                    ? ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(
                            top: 0, bottom: 0, left: 15, right: 15),
                        leading: Icon(MdiIcons.mapMarker),
                        title: Text(userProfile!.profile.address),
                        isThreeLine: false,
                      )
                    : SizedBox(height: 0),
                Divider(
                  thickness: 10,
                  color: Colors.grey[300],
                ),
                // Text(
                //   "Bài Viết Của Bạn",
                //   textAlign: TextAlign.start,
                //   textScaleFactor: 1.5,
                //   selectionColor: Colors.black87,
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // StatusSection(),
                // Divider(
                //   thickness: 1,
                //   color: Colors.grey[300],
                // ),
                _renderPosts(context, userProfile!.posts),
                // Divider(
                //   thickness: 10,
                //   color: Colors.grey[300],
                // ),
                userProfile!.profile.fullContent == ""
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
                              data: userProfile!.profile.fullContent,
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

  Widget _renderPosts(BuildContext context, PostPagingDTO post) {
    List<Widget> list = [];
    post.data.forEach((PostDTO post) {
      list.add(PostCard(
        post: post,
      ));
    });
    return Column(children: list);
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
            child: (userProfile!.profile.image != "")
                ? CircleAvatar(
                    radius: size / 2 - 2.0,
                    backgroundImage:
                        CachedNetworkImageProvider(userProfile!.profile.image))
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
      child: userProfile!.profile.banner != ""
          ? CustomCachedImage(url: userProfile!.profile.banner)
          : SizedBox(height: size),
    );
  }
}
