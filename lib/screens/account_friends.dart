import 'dart:math' as math;

import 'package:anylearn/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/account/account_blocs.dart';
import '../blocs/auth/auth_blocs.dart';
import '../dto/friends_dto.dart';
import '../models/user_repo.dart';
import 'account/app_bar_with_image.dart';
import 'loading.dart';

class AccountFriendsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountFriendsScreen();
}

class _AccountFriendsScreen extends State<AccountFriendsScreen> {
  FriendsDTO _data;
  AccountBloc _accountBloc;
  AuthBloc _authBloc;

  @override
  void didChangeDependencies() {
    final userRepo = RepositoryProvider.of<UserRepository>(context);
    _accountBloc = AccountBloc(userRepository: userRepo);
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    int friendsOfUserId = ModalRoute.of(context).settings.arguments;
    // var moneyFormat = new NumberFormat("###,###,###", "vi_VN");
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AuthFailState) {
          Navigator.of(context).popUntil(ModalRoute.withName("/"));
          Navigator.of(context).pushNamed("/login");
        }
        if (state is AuthSuccessState) {
          _accountBloc.add(AccLoadFriendsEvent(token: state.user.token, userId: friendsOfUserId));
        }
      },
      child: Scaffold(
        body: BlocProvider<AccountBloc>(
          create: (context) => _accountBloc,
          child: BlocListener<AccountBloc, AccountState>(
            listener: (context, state) {
              if (state is AccountFailState) {
                Navigator.of(context).pop();
              }
            },
            child: BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
              if (state is AccFriendsLoadSuccessState) {
                _data = state.friends;
              }
              return _data == null
                  ? LoadingWidget()
                  : CustomScrollView(
                      slivers: <Widget>[
                        AccountAppBarWithImage(user: _data.user),
                        SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                            ),
                            child: Text("Bạn bè của " + _data.user.name + " (MGT: " + _data.user.refcode + ")",
                                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                          ),
                        ),
                        // SliverToBoxAdapter(
                        //   child: Container(
                        //       padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        //       decoration: BoxDecoration(
                        //           // color: Colors.grey[100],
                        //           ),
                        //       child: Row(children: [
                        //         Icon(
                        //           Icons.info,
                        //           color: Colors.grey,
                        //           size: 12.0,
                        //         ),
                        //         Text(" Chạm để xem cấp duới. Giữ để xem thông tin.",
                        //             style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                        //       ])),
                        // ),
                        _data.friends != null && _data.friends.length > 0
                            ? SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final itemIndex = index ~/ 2;
                                    if (index.isEven) {
                                      return ListTile(
                                        leading: _data.friends[itemIndex].image != null &&
                                                _data.friends[itemIndex].image.isNotEmpty
                                            ? CircleAvatar(
                                                radius: 28,
                                                backgroundColor: _roleColor(_data.friends[itemIndex].role),
                                                child: CircleAvatar(
                                                  radius: 27,
                                                  backgroundImage: NetworkImage(
                                                    _data.friends[itemIndex].image,
                                                  ),
                                                ),
                                              )
                                            : Icon(
                                                Icons.account_circle,
                                                size: 56.0,
                                                color: _roleColor(
                                                  _data.friends[itemIndex].role,
                                                ),
                                              ),
                                        title: Text(_data.friends[itemIndex].name),
                                        subtitle: _data.friends[itemIndex].title != null
                                            ? Text(_data.friends[itemIndex].title)
                                            : SizedBox(height: 0),
                                        trailing: SizedBox(
                                            width: 80.0,
                                            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                              // Text(_data.friends[itemIndex].numFriends.toString() + " bạn "),
                                              Icon(Icons.arrow_right),
                                            ])),
                                        onTap: () {
                                          Navigator.of(context).pushNamed("/account/friends", arguments: _data.friends[itemIndex].id);
                                        },
                                        // onLongPress: () {
                                        //   Navigator.of(context).pushNamed("/account");
                                        // },
                                      );
                                    }
                                    return Divider(
                                      height: 0.0,
                                    );
                                  },
                                  semanticIndexCallback: (Widget widget, int localIndex) {
                                    if (localIndex.isEven) {
                                      return localIndex ~/ 2;
                                    }
                                    return null;
                                  },
                                  childCount: math.max(0, _data.friends.length * 2 - 1),
                                ),
                              )
                            : SliverToBoxAdapter(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Text("Hiện tại chưa có cấp dưới nào"),
                                ),
                              ),
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }

  Color _roleColor(String role) {
    switch (role) {
      case "teacher":
        return Colors.orange;
      case "school":
        return Colors.blue;
      default:
        return Colors.green;
    }
  }
}
