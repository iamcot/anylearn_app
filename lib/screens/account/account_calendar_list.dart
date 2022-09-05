import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/account/account_blocs.dart';
import '../../dto/const.dart';
import '../../dto/event_dto.dart';
import '../../main.dart';
import '../../widgets/calendar_box.dart';
import '../rating_input.dart';

class AccountCalendarList extends StatefulWidget {
  final List<EventDTO> events;
  final isOpen;
  final AccountBloc accountBloc;

  const AccountCalendarList({key, required this.events, this.isOpen, required this.accountBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountCalendarList();
}

class _AccountCalendarList extends State<AccountCalendarList> with TickerProviderStateMixin {
  late List<AnimationController> controllers;

  String timerString(AnimationController controller) {
    Duration duration = controller.duration! * controller.value;
    return '${(duration.inHours).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controllers = List.empty(growable: true);
  }

  @override
  void dispose() {
    controllers.forEach((e) {
      e.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String nowStr = DateFormat("yyyy-MM-dd").format(DateTime.now());
    return CustomScrollView(
      slivers: <Widget>[
        widget.events.length > 0
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final itemIndex = index ~/ 2;
                    if (index.isEven) {
                      return ListTile(
                        leading: CalendarBox(
                          fontSize: 12,
                          text: DateFormat("dd/MM").format(DateTime.parse(widget.events[itemIndex].date)),
                          image: widget.events[itemIndex].image,
                        ),
                        title: Text(widget.events[itemIndex].title),
                        subtitle: Text.rich(TextSpan(
                          text: (widget.events[itemIndex].itemSubtype == MyConst.ITEM_SUBTYPE_OFFLINE &&
                                  widget.events[itemIndex].scheduleContent != widget.events[itemIndex].title)
                              ? widget.events[itemIndex].scheduleContent
                              : "",
                          children: [
                            TextSpan(
                                text: widget.events[itemIndex].childName != null
                                    ? "[" + widget.events[itemIndex].childName + "] "
                                    : ""),
                            TextSpan(text: widget.events[itemIndex].time),
                            TextSpan(
                                text: widget.events[itemIndex].userJoined == null ? "" : "\nĐã xác nhận",
                                style: TextStyle(color: Colors.green))
                          ],
                        )),
                        trailing: widget.events[itemIndex].authorStatus == MyConst.ITEM_USER_STATUS_CANCEL
                            ? Text("Lớp đã hủy")
                            : _buildTrailing(widget.events[itemIndex]),
                        onLongPress: () {
                          Navigator.of(context).pushNamed("/pdp", arguments: widget.events[itemIndex].itemId);
                        },
                      );
                    }
                    return Divider(
                      height: 0.0,
                    );
                  },
                  semanticIndexCallback: (Widget widget, int localIndex) {
                    if (localIndex.isEven) {}
                    return null;
                  },
                  childCount: math.max(0, widget.events.length * 2 - 1),
                ),
              )
            : SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text.rich(
                    TextSpan(
                      text: "Bạn không có lịch học nào.",
                      style: TextStyle(fontSize: 16.0),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Xem các lịch học đang có",
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushNamed("/event");
                              }),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              )
      ],
    );
  }

  Widget _buildTrailing(EventDTO event) {
    if (!widget.isOpen) {
      if (event.userJoined == null) {
        return BlocBuilder<AccountBloc, AccountState>(
          bloc: widget.accountBloc,
          builder: (context, state) {
            return event.userJoined != null && event.userJoined > 0
                ? Text("Đã tham gia")
                : ElevatedButton(
                    onPressed: () {
                      widget.accountBloc
                        ..add(AccJoinCourseEvent(
                            token: user.token, itemId: event.itemId, scheduleId: event.id, childId: event.childId));
                    },
                    child: Text(
                      "Xác nhận",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ));
          },
        );
      } else {
        return RaisedButton(
            onPressed: () {
              _dialogJoin(event, false);
            },
            color: Colors.blue,
            child: Text(
              "Đánh giá",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ));
      }
    } else {
      final today = DateFormat("yyyy-MM-dd").format(DateTime.now());
      if (today == event.date || event.nolimitTime) {
        if (event.userJoined == null) {
          Duration diffInSeconds = DateTime.parse(event.date + " " + event.time).difference(DateTime.now());
          if (!diffInSeconds.isNegative && diffInSeconds < Duration(hours: 24)) {
            AnimationController controller = AnimationController(
              vsync: this,
              duration: diffInSeconds,
            );
            controllers.add(controller);
            controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
            return AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return controller.isAnimating
                      ? RaisedButton(
                          onPressed: () {
                            _dialogJoin(event, false);
                          },
                          child: Text(
                            timerString(controller),
                            style: TextStyle(fontSize: 12),
                          ))
                      : RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            _dialogJoin(event, true);
                          },
                          child: Text(
                            "Tham gia",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ));
                });
          } else if (diffInSeconds >= Duration(hours: 24)) {
             return Text("Chưa diễn ra");;
          } else {
            return BlocBuilder<AccountBloc, AccountState>(
              bloc: widget.accountBloc,
              builder: (context, state) {
                return event.userJoined != null && event.userJoined > 0
                    ? RaisedButton(
                        onPressed: () {
                          _dialogJoin(event, false);
                        },
                        color: Colors.blue,
                        child: Text(
                          "Vào lớp",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ))
                    : RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          _dialogJoin(event, true);
                        },
                        child: Text(
                          "Tham gia",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ));
              },
            );
          }
        } else {
          return RaisedButton(
              onPressed: () {
                _dialogJoin(event, false);
              },
              color: Colors.blue,
              child: Text(
                "Vào lớp",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ));
        }
      } else {
        return Text("Chưa diễn ra");
      }
    }
  }

  void _dialogJoin(EventDTO eventDTO, bool hasConfirm) {
    String route = "";
    String routeInfo = "";
    OnlineScheduleInfoDTO onlineScheduleInfoDTO = OnlineScheduleInfoDTO();
    if (eventDTO.itemSubtype == MyConst.ITEM_SUBTYPE_ONLINE) {
      try {
        onlineScheduleInfoDTO = OnlineScheduleInfoDTO.fromJson(jsonDecode(eventDTO.scheduleContent));
      } catch (e) {}

      if (onlineScheduleInfoDTO.url != "") {
        route = onlineScheduleInfoDTO.url;
        routeInfo = onlineScheduleInfoDTO.info;
      } else if (eventDTO.location != "") {
        route = eventDTO.location;
      } else {
        routeInfo = "Vui lòng chờ cập nhật thông tin lớp học.";
      }
    } else {
      routeInfo = eventDTO.scheduleContent;
    }
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: <Widget>[
          eventDTO.itemSubtype != MyConst.ITEM_SUBTYPE_ONLINE
              ? Container()
              : ListTile(
                  title: Text("Vào lớp học"),
                  subtitle: Text.rich(TextSpan(text: route, children: [
                    routeInfo.isEmpty ? TextSpan(text: "") : TextSpan(text: "\n" + routeInfo),
                  ])),
                  onTap: () async {
                    Navigator.of(context).pop();
                    if (route != "") {
                      if (Platform.isIOS) {
                        if (await canLaunch(route)) {
                          await launch(route, forceSafariVC: false);
                        } else {
                          if (await canLaunch(route)) {
                            await launch(route);
                          } else {
                            toast("Đường dẫn lớp học không đúng, vui lòng kiểm tra lại với người phụ trách.");
                            throw 'Could not launch';
                          }
                        }
                      } else {
                        if (await canLaunch(route)) {
                          await launch(route);
                        } else {
                          throw 'Could not launch';
                        }
                      }
                    }
                  },
                ),
          hasConfirm ? Divider() : SizedBox(height: 0),
          hasConfirm
              ? ListTile(
                  title: Text("Xác nhận tham gia"),
                  onTap: () {
                    widget.accountBloc
                      ..add(AccJoinCourseEvent(
                          token: user.token,
                          itemId: eventDTO.itemId,
                          scheduleId: eventDTO.id,
                          childId: eventDTO.childId));
                    Navigator.of(context).pop();
                  },
                )
              : Text(""),
          !hasConfirm ? Divider() : SizedBox(height: 0),
          !hasConfirm
              ? ListTile(
                  trailing: eventDTO.userRating > 0
                      ? Text("LÀM LẠI", style: TextStyle(color: Colors.blue))
                      : Icon(Icons.chevron_right),
                  title:
                      Text(eventDTO.userRating > 0 ? "Bạn đã đánh giá ${eventDTO.userRating}*" : "Đánh giá khóa học"),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final sentReview = await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return RatingInputScreen(
                          user: user,
                          itemId: eventDTO.itemId,
                          itemTitle: eventDTO.title,
                          lastRating: eventDTO.userRating);
                    }));
                    if (sentReview) {
                      widget.accountBloc..add(AccLoadMyCalendarEvent(token: user.token));
                    }
                  },
                )
              : SizedBox(height: 0),
        ],
      ),
    );
  }
}
