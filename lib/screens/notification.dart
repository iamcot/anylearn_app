import 'package:anylearn/screens/webview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:overlay_support/overlay_support.dart';

import '../blocs/auth/auth_blocs.dart';
import '../blocs/notif/notif_blocs.dart';
import '../dto/notification_dto.dart';
import '../dto/user_dto.dart';
import '../widgets/loading_widget.dart';
import '../widgets/time_ago.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  late AuthBloc _authBloc;
  late NotifBloc _notifBloc;
  late UserDTO _user;
  late NotificationPagingDTO _notif;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    _notifBloc = BlocProvider.of<NotifBloc>(context);
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
          _notifBloc..add(NotifLoadEvent(token: _user.token));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Thông báo").tr(),
          centerTitle: false,
        ),
        body: BlocBuilder(
            bloc: _notifBloc,
            builder: (context, state) {
              if (state is NotifSuccessState) {
                _notif = state.notif;
                return RefreshIndicator(
                    onRefresh: () async {
                      _notifBloc..add(NotifLoadEvent(token: _user.token));
                    },
                    child: _notif.total == 0
                        ? Container(
                            alignment: Alignment.center,
                            child: Text("Bạn chưa có thông báo nào.").tr(),
                          )
                        : ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                color: _notif.data[index].read == null ? Colors.blue[50] : Colors.white,
                                child: ListTile(
                                  onTap: () {
                                    _notifBloc..add(NotifReadEvent(token: _user.token, id: _notif.data[index].id));
                                    if (_notif.data[index].extraContent == "copy") {
                                      Clipboard.setData(new ClipboardData(text: _notif.data[index].route));
                                      toast("Đã copy vào bộ nhớ".tr());
                                      _notifBloc..add(NotifLoadEvent(token: _user.token));
                                    } else if (_notif.data[index].extraContent == "url" &&
                                        _notif.data[index].route != null) {
                                      _notifBloc..add(NotifLoadEvent(token: _user.token));
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => WebviewScreen(
                                                url: _notif.data[index].route,
                                              )));
                                    } else if (_notif.data[index].route != null) {
                                      _notifBloc..add(NotifLoadEvent(token: _user.token));
                                      Navigator.of(context).pushNamed(_notif.data[index].route,
                                          arguments: _notif.data[index].extraContent);
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
                                  color: Colors.grey,
                                  height: 0,
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
