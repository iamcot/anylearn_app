import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../blocs/account/account_blocs.dart';
import '../customs/custom_cached_image.dart';
import '../dto/const.dart';
import '../dto/likecomment/post_dto.dart';
import '../dto/user_dto.dart';
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
  UserProfileDTO? userProfile;

  @override
  void didChangeDependencies() {
    final _userRepo = RepositoryProvider.of<UserRepository>(context);
    _accountBloc = AccountBloc(userRepository: _userRepo);
    int userId = 0;
    int postId = 0;
    try {
      userId = int.parse(ModalRoute.of(context)!.settings.arguments.toString());
      postId = int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    } catch (e) {
      if (user.id > 0) {
        userId = user.id;
      }
    }
    if (userId == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Navigator.of(context).pop();
      });
    }
    // if (postId == 0) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     Navigator.of(context).pop();
    //   });
    // }
     else {
      _accountBloc..add(AccProfileEvent(userId: userId));
      _accountBloc..add(AccPostEvent(id: postId));
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
                  userProfile!.userprofile.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                userProfile!.userprofile.role != MyConst.ROLE_SCHOOL
                    ? Text(
                        userProfile!.userprofile.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(),
                      )
                    : SizedBox(height: 0),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(userProfile!.userprofile.introduce,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: Colors.blue,
                      )),
                ),
                userProfile!.userprofile.role == MyConst.ROLE_SCHOOL &&
                        userProfile!.userprofile.title != ""
                    ?
                    // Container(
                    //     padding: EdgeInsets.only(left: 15, right: 15),
                    //     child: Text.rich(TextSpan(text: "Người đại diện: ", children: [TextSpan(text: user!.title)])))
                    ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(
                            top: 0, bottom: 0, left: 15, right: 15),
                        leading: Icon(MdiIcons.shieldAccount),
                        title: Text("Người đại diện: " +
                                userProfile!.userprofile.title)
                            .tr(),
                        isThreeLine: false,
                      )
                    : SizedBox(height: 0),
                userProfile!.userprofile.address != ""
                    ? ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(
                            top: 0, bottom: 0, left: 15, right: 15),
                        leading: Icon(MdiIcons.mapMarker),
                        title: Text(userProfile!.userprofile.address),
                        isThreeLine: false,
                      )
                    : SizedBox(height: 0),
                Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                Text(
                  "Bài Viết Của Bạn",
                  textAlign: TextAlign.start,
                  textScaleFactor: 1.5,
                  selectionColor: Colors.black87,
                ),
                SizedBox(
                  height: 15,
                ),
                StatusSection(),
                Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                // userProfile!.role == MyConst.POST_TYPE_REGISTERED &&
                //         userProfile!.title != ""
                //     ?
                // if(state is AccPostSuccessState){
                //   userProfile?.post = state.data;
                //   return
                // },

                _renderPosts(context, userProfile!.post),

                Divider(
                  thickness: 10,
                  color: Colors.grey[300],
                ),
                // userProfile!.role == MyConst.POST_TYPE_FINAL &&
                //         userProfile!.title != ""
                //     ?

                // userProfile!.docs == null || userProfile!.docs.length == 0
                //     ? SizedBox(height: r0)
                //     : Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget>[
                //           Divider(),
                //           Padding(
                //             padding: const EdgeInsets.only(left: 15, right: 15),
                //             child: Text(
                //               "Chứng chỉ",
                //               style: TextStyle(fontWeight: FontWeight.bold),
                //             ).tr(),
                //           )
                //         ],
                //       ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 15, right: 15),
                //   child: userProfile!.docs == null || userProfile!.docs.length == 0
                //       ? SizedBox(height: 0)
                //       : UserDocList(userDocs: userProfile!.docs),
                // ),

                // (userProfile!.registered == null || userProfile!.registered.length == 0)
                //     ? SizedBox(height: 0)
                //     : Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           // Divider(
                //           //   thickness: 10,
                //           // ),
                //           HotItems(
                //             hotItems: [HotItemsDTO(title: "Các khoá học đã đăng ký".tr(), list: userProfile!.registered)],
                //           ),
                //         ],
                //       ),
                // (userProfile!.faved == null || userProfile!.faved.length == 0)
                //     ? SizedBox(height: 0)
                //     : Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           // Divider(
                //           //   thickness: 10,
                //           // ),
                //           HotItems(
                //             hotItems: [HotItemsDTO(title: "Các khoá học đang quan tâm".tr(), list: userProfile!.faved)],
                //           ),
                //         ],
                //       ),
                // (userProfile!.rated == null || userProfile!.rated.length == 0)
                //     ? SizedBox(height: 0)
                //     : Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           // Divider(
                //           //   thickness: 10,
                //           // ),
                //           HotItems(
                //             hotItems: [HotItemsDTO(title: "Các khoá học đã đánh giá".tr(), list: userProfile!.rated)],
                //           ),
                //         ],
                //       ),
                userProfile!.userprofile.fullContent == ""
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
                              data: userProfile!.userprofile.fullContent,
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
    post.data.foreach((PostDTO post) {
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
            child: (userProfile!.userprofile.image != "")
                ? CircleAvatar(
                    radius: size / 2 - 2.0,
                    backgroundImage: CachedNetworkImageProvider(
                        userProfile!.userprofile.image))
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
      child: userProfile!.userprofile.banner != ""
          ? CustomCachedImage(url: userProfile!.userprofile.banner)
          : SizedBox(height: size),
    );
  }
}

class UserProfileDTO {
  final PostPagingDTO post;
  final UserDTO userprofile;
  UserProfileDTO({
    required this.post,
    required this.userprofile,
  });
}
