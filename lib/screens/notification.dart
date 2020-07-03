import 'package:anylearn/widgets/loading_widget.dart';
import 'package:anylearn/widgets/time_ago.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../blocs/auth/auth_blocs.dart';
import '../dto/notification_dto.dart';
import '../dto/user_dto.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  AuthBloc _authBloc;
  UserDTO _user;
  NotificationPagingDTO _notif;

  @override
  void didChangeDependencies() {
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _authBloc,
      listener: (BuildContext context, state) {
        if (state is AuthFailState) {
          Navigator.of(context).popAndPushNamed("/login");
        }
        if (state is AuthSuccessState) {
          _user = state.user;
          _authBloc..add(AuthNotifEvent(token: _user.token));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Thông báo"),
          centerTitle: false,
        ),
        body: BlocBuilder(
            bloc: _authBloc,
            builder: (context, state) {
              if (state is AuthNotifSuccessState) {
                _notif = state.notif;
                return RefreshIndicator(
                    onRefresh: () async {
                      _authBloc..add(AuthNotifEvent(token: _user.token));
                    },
                    child: _notif.total == 0
                        ? Container(
                            alignment: Alignment.center,
                            child: Text("Bạn chưa có thông báo nào."),
                          )
                        : ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                color: _notif.data[index].read == null ? Colors.blue[50] : Colors.white,
                                child: ListTile(
                                  onTap: () {
                                    // _authBloc..add(AuthNotifReadEvent(token: _user.token, id: _notif.data[index].id));
                                    if (_notif.data[index].route != null) {
                                      Navigator.of(context).pushNamed(_notif.data[index].route,
                                          arguments: _notif.data[index].extraContent ?? null);
                                    }
                                  },
                                  leading: Icon(
                                    _buildIcon(_notif.data[index].type),
                                    size: 30,
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  title: Text(_notif.data[index].content),
                                  subtitle: TimeAgo(time: _notif.data[index].createdAt),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => Divider(
                                  height: 0,
                                  color: Colors.grey,
                                ),
                            itemCount: _notif.data.length));
              }
              return LoadingWidget();
            }),
      ),
    );
  }

  IconData _buildIcon(String type) {
    switch (type) {
      case "new_user":
        return MdiIcons.fire;
      case "new_friend":
        return MdiIcons.accountHeart;
      default:
        return Icons.info_outline;
    }
  }
}
