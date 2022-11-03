import 'package:anylearn/dto/user_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:validators/validators.dart';

import '../blocs/account/account_blocs.dart';
import '../customs/custom_cached_image.dart';
import '../dto/const.dart';
import '../dto/profilelikecmt/post_dto.dart';
import '../dto/profilelikecmt/profile_dto.dart';
import '../main.dart';
import '../models/user_repo.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fab_home.dart';
import '../widgets/loading_widget.dart';
import '../widgets/postcard.dart';

class AccountProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountProfileScreen();
}

class _AccountProfileScreen extends State<AccountProfileScreen> {
  late AccountBloc _accountBloc;
  ProfileDTO? userProfile;
  ScrollController _scrollController = ScrollController();
  late double _scrollPosition;

  int page = 0;

  void _scrollListener() {
    if (_scrollController.hasClients) {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent - 10 &&
          !_scrollController.position.outOfRange) {
        page += 1;

        print("reach the bottom");
        _accountBloc..add(AccProfileEvent(userId: user.userId, page: page));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

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
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Navigator.of(context).pop();
      });
    } else {
      _accountBloc..add(AccProfileEvent(userId: userId, page: page));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<AccountBloc, AccountState>(
        bloc: _accountBloc,
        builder: (context, state) {
          if (state is AccProfileLoadSuccessState) {
            // if (page < 2) {
            userProfile = state.data;
          

            // } else {
            //   // userProfile!.posts.data += state.profile;
            // }
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
                  controller: _scrollController,
                  children: [
                    Column(
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
                            ? ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 15, right: 15),
                                leading: Icon(MdiIcons.shieldAccount),
                                title: Text("Người đại diện: " +
                                        userProfile!.profile.title)
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
                        userProfile?.posts.data[0] ==
                                MyConst.TYPE_CLASS_REGISTER
                            ? Container(
                                child:
                                    _renderPosts(context, userProfile!.posts),
                              )
                            : SizedBox(height: 0),
                        userProfile?.posts.data[1] == MyConst.TYPE_CLASS_FAV
                            ? Container(
                                child:
                                    _renderPosts(context, userProfile!.posts),
                              )
                            : SizedBox(height: 0),
                        userProfile?.posts.data[1] ==
                                MyConst.TYPE_CLASS_COMPLETE
                            ? Container(
                                child:
                                    _renderPosts(context, userProfile!.posts),
                              )
                            : SizedBox(height: 0),
                        userProfile?.posts.data[1] == MyConst.TYPE_CLASS_SHARED
                            ? Container(
                                child:
                                    _renderPosts(context, userProfile!.posts),
                              )
                            : SizedBox(height: 0),
                        userProfile?.posts.data[1] == MyConst.TYPE_CLASS_CERT
                            ? Container(
                                child:
                                    _renderPosts(context, userProfile!.posts),
                              )
                            : SizedBox(height: 0),
                        userProfile?.posts.data[1] == MyConst.TYPE_CLASS_RATING
                            ? Container(
                                child:
                                    _renderPosts(context, userProfile!.posts),
                              )
                            : SizedBox(height: 0),
                      ],
                    )
                  ],

                  // controller: _scrollController,
                ));
          }

          return LoadingWidget();
        });
  }

  Widget _renderPosts(BuildContext context, PostPagingDTO post) {
    List<Widget> list = [];
    post.data.forEach((PostDTO post) {
      list.add(PostCard(
        // type: type,
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
