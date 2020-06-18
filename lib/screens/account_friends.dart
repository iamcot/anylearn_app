import 'dart:math' as math;

import 'package:anylearn/dto/user_dto.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/account/account_blocs.dart';
import '../blocs/auth/auth_blocs.dart';
import '../customs/feedback.dart';
import '../dto/friend_params_dto.dart';
import '../dto/friends_dto.dart';
import '../models/user_repo.dart';
import '../widgets/loading_widget.dart';
import 'account/app_bar_with_image.dart';

class AccountFriendsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountFriendsScreen();
}

class _AccountFriendsScreen extends State<AccountFriendsScreen> {
  FriendsDTO _data;
  AccountBloc _accountBloc;
  AuthBloc _authBloc;
  UserDTO _user;

  @override
  void didChangeDependencies() {
    final userRepo = RepositoryProvider.of<UserRepository>(context);
    _accountBloc = AccountBloc(userRepository: userRepo);
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    FriendParamsDTO param = ModalRoute.of(context).settings.arguments;
    // var moneyFormat = new NumberFormat("###,###,###", "vi_VN");
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AuthFailState) {
          Navigator.of(context).popUntil(ModalRoute.withName("/"));
          Navigator.of(context).pushNamed("/login");
        }
        if (state is AuthSuccessState) {
          _user = state.user;
          _accountBloc.add(AccLoadFriendsEvent(token: state.user.token, userId: param.userId));
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
                  : CustomFeedback(
                      user: _user,
                      child: CustomScrollView(
                        slivers: <Widget>[
                          AccountAppBarWithImage(user: _data.user),
                          SliverToBoxAdapter(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                              ),
                              child: Text("Bạn bè của " + _data.user.name + " (MGT: " + _data.user.refcode + ")",
                                  style:
                                      TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                decoration: BoxDecoration(
                                    // color: Colors.grey[100],
                                    ),
                                child: Row(children: [
                                  Icon(
                                    Icons.info,
                                    color: Colors.grey,
                                    size: 12.0,
                                  ),
                                  Expanded(
                                    child: Text("Chạm để xem bạn bè liên kết. Giữ để xem thông tin cá nhân.",
                                        style: TextStyle(
                                            fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                                  ),
                                ])),
                          ),
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
                                                Icon(Icons.chevron_right),
                                              ])),
                                          onTap: () {
                                            if (param.level < 3) {
                                              Navigator.of(context).pushNamed("/account/friends",
                                                  arguments: FriendParamsDTO(
                                                      userId: _data.friends[itemIndex].id, level: param.level + 1));
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  child: AlertDialog(
                                                    content: Text(
                                                        "Bạn không thể xem thêm bạn bè, đây là nhánh liên kết cuối của bạn, hãy chia sẻ MÃ GIỚI THIỆU để có thêm nhiều bạn cùng học hơn!!!"),
                                                    actions: <Widget>[
                                                      RaisedButton(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                        ),
                                                        color: Colors.blue,
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                          Navigator.of(context).pushNamed("/qrcode",
                                                              arguments: _data.friends[itemIndex].id);
                                                        },
                                                        child: Text("GIỚI THIỆU BẠN BÈ"),
                                                      )
                                                    ],
                                                  ));
                                            }
                                          },
                                          onLongPress: () {
                                            Navigator.of(context)
                                                .pushNamed("/profile", arguments: _data.friends[itemIndex].id);
                                          },
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
                                    child: param.level == 1
                                        ? Text.rich(
                                            TextSpan(
                                              text: "Hiện tại chưa có bạn nào.",
                                              style: TextStyle(fontSize: 16.0),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: " CHIA SẼ MÃ GIỚI THIỆU",
                                                    style: TextStyle(color: Colors.blue),
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.of(context).pushNamed("/qrcode");
                                                      }),
                                                TextSpan(text: " để có thêm bạn nhé.")
                                              ],
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        : Text("Chưa có bạn nào."),
                                  ),
                                ),
                        ],
                      ),
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
