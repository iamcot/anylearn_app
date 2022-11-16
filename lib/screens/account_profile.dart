import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/screens/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:validators/validators.dart';

import '../blocs/account/account_blocs.dart';
import '../customs/custom_cached_image.dart';
import '../dto/const.dart';
import '../dto/profilelikecmt/post_dto.dart';
import '../dto/profilelikecmt/profile_dto.dart';
import '../main.dart';
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

  int page = 1;
  int userId = 0;
  bool isLoading = false;
  int maxPage = 1;

  void _scrollListener() {
    if (_scrollController.hasClients) {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent - 10 &&
          !_scrollController.position.outOfRange &&
          page < maxPage) {
        page += 1;

        if (!isLoading) {
          if (userId == 0) {
            _accountBloc..add(AccProfileEvent(token: user.token, page: page));
          } else {
            _accountBloc
              ..add(AccFriendProfileEvent(userId: userId, page: page));
          }
          setState(() {
            isLoading = true;
          });
        }
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
    _accountBloc = BlocProvider.of<AccountBloc>(context);

    try {
      userId = int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    } catch (e) {}

    if (userId == 0) {
      _accountBloc..add(AccProfileEvent(token: user.token, page: page));
    } else {
      _accountBloc..add(AccFriendProfileEvent(userId: userId, page: page));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocListener<AccountBloc, AccountState>(
      bloc: _accountBloc,
      listener: (context, state) {
        if (state is AccProfileFailState) {
          toast(state.error.toString());
          isLoading = false;
        }
        if (state is ActionUserSuccessState){
          if (userId == 0) {
            _accountBloc..add(AccProfileEvent(token: user.token, page: page));
          } else {
            _accountBloc
              ..add(AccFriendProfileEvent(userId: userId, page: page));
          }
        }
      },
      child: BlocBuilder<AccountBloc, AccountState>(
          bloc: _accountBloc,
          builder: (context, state) {
            if (state is AccProfileLoadSuccessState) {
              if (page == 1) {
                userProfile = state.data;
                maxPage = userProfile?.posts.lastPage;
              } else {
                userProfile?.posts.data += state.data.posts.data;
              }
              isLoading = false;
            }

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
                body: userProfile == null
                    ? LoadingWidget()
                    : ListView(
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
                              userProfile!.profile.role ==
                                          MyConst.ROLE_SCHOOL &&
                                      userProfile!.profile.title != ""
                                  ? ListTile(
                                      dense: true,
                                      contentPadding: EdgeInsets.only(
                                          top: 0,
                                          bottom: 0,
                                          left: 15,
                                          right: 15),
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
                                          top: 0,
                                          bottom: 0,
                                          left: 15,
                                          right: 15),
                                      leading: Icon(MdiIcons.mapMarker),
                                      title: Text(userProfile!.profile.address),
                                      isThreeLine: false,
                                    )
                                  : SizedBox(height: 0),
                              Divider(
                                thickness: 10,
                                color: Colors.grey[300],
                              ),
                              ...renderType(userProfile?.posts.data)
                            ],
                          )
                        ],
                        // controller: _scrollController,
                      ));
          }),
    );
  }

  List<Widget> renderType(List<PostDTO>? listPostDTO) {
    List<Widget> listWidget = List.empty(growable: true);
    if (listPostDTO == null) return listWidget;
    listPostDTO.forEach((postDTO) {
      listWidget.add(PostCard(
        post: postDTO,
      ));
    });
    return listWidget;
  }

  // Widget _renderPosts(BuildContext context, PostPagingDTO post) {
  //   List<Widget> list = [];
  //   post.data.forEach((PostDTO post) {
  //     list.add(PostCard(
  //       // type: type,
  //       post: post,
  //     ));
  //   });
  //   return Column(children: list);
  // }

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
