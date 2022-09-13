import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../blocs/course/course_blocs.dart';
import '../../dto/const.dart';
import '../../dto/course_registered_params_dto.dart';
import '../../dto/item_dto.dart';
import '../../dto/user_dto.dart';
import '../../widgets/calendar_box.dart';

class CourseList extends StatelessWidget {
  final CourseBloc courseBloc;
  final UserDTO user;
  final bool hasMenu;
  final List<ItemDTO> list;
  final shortDayFormat = DateFormat("dd/MM");

  CourseList({key, required this.list, required this.hasMenu, required this.courseBloc, required this.user})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return list.length > 0
        ? ListView.separated(
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                if (hasMenu) {
                  showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      children: <Widget>[
                        ListTile(
                            trailing: Icon(Icons.edit),
                            title: Text("Chỉnh sửa khóa học"),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed("/course/form", arguments: list[index].id);
                            }),
                        Divider(),
                        ListTile(
                            trailing: Icon(Icons.assignment_turned_in),
                            title: Text("Danh sách đăng ký"),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed('/course/registered',
                                  arguments: CourseRegisteredPramsDTO(token: user.token, itemId: list[index].id));
                            }),
                        Divider(),
                        _userStatusAction(context, list[index]),
                        Divider(),
                        ListTile(
                            trailing: Icon(Icons.close),
                            title: Text("Hủy lớp"),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: Text(
                                            "Bạn chắc chắn muốn đóng lớp này? Lớp đã đóng không thể mở lại, xin hãy xác nhận."),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Quay lại")),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.red,
                                              ),
                                              child: Text("Hủy lớp"),
                                              onPressed: () {
                                                courseBloc.add(CourseChangeUserStatusEvent(
                                                    itemId: list[index].id,
                                                    token: user.token,
                                                    newStatus: MyConst.ITEM_USER_STATUS_CANCEL));
                                                Navigator.of(context).pop();
                                              }),
                                        ],
                                      ));
                            }),
                      ],
                    ),
                  );
                }
              },
              leading: CalendarBox(
                  image: list[index].image,
                  fontSize: 12,
                  text: shortDayFormat.format(DateTime.parse(list[index].dateStart))),
              title: Text(list[index].title),
              subtitle: Text.rich(
                TextSpan(
                    text: list[index].timeStart + " " + list[index].dateStart,
                    style: TextStyle(fontSize: 12),
                    children: [
                      TextSpan(text: "\n"),
                      _userStatusStr(list[index].userStatus),
                    ]),
              ),
              trailing: list[index].status == 0
                  ? Text(
                      "Đang duyệt",
                      style: TextStyle(color: Colors.red),
                    )
                  : Text(
                      "Đã duyệt",
                      style: TextStyle(color: Colors.green),
                    ),
            ),
            separatorBuilder: (context, index) => Divider(),
            itemCount: list.length,
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(TextSpan(text: "Bạn không có khóa học nào.")),
          );
  }

  TextSpan _userStatusStr(int status) {
    switch (status) {
      case MyConst.ITEM_USER_STATUS_INACTIVE:
        return TextSpan(
          text: "Chưa mở ",
          style: TextStyle(color: Colors.grey),
        );
      case MyConst.ITEM_USER_STATUS_ACTIVE:
        return TextSpan(
          text: "Đang mở ",
          style: TextStyle(color: Colors.green),
        );
      case MyConst.ITEM_USER_STATUS_DONE:
        return TextSpan(
          text: "Đã xong",
          style: TextStyle(color: Colors.green),
        );
      case MyConst.ITEM_USER_STATUS_CANCEL:
        return TextSpan(
          text: "Đã hủy",
          style: TextStyle(color: Colors.red),
        );
      default:
        return TextSpan(
          text: "-",
          style: TextStyle(color: Colors.grey),
        );
    }
  }

  Widget _userStatusAction(BuildContext context, ItemDTO itemDTO) {
    switch (itemDTO.userStatus) {
      case MyConst.ITEM_USER_STATUS_INACTIVE:
        return ListTile(
            trailing: Icon(Icons.play_circle_outline),
            title: Text("Mở lớp nhận đăng ký"),
            onTap: () {
              courseBloc.add(CourseChangeUserStatusEvent(
                  itemId: itemDTO.id, token: user.token, newStatus: MyConst.ITEM_USER_STATUS_ACTIVE));
              Navigator.of(context).pop();
            });

      case MyConst.ITEM_USER_STATUS_ACTIVE:
        if (DateTime.now().isAfter(DateTime.parse(itemDTO.dateStart + " " + itemDTO.timeStart))) {
          return ListTile(
              trailing: Icon(Icons.check),
              title: Text("Lớp đã hoàn thành"),
              onTap: () {
                courseBloc.add(CourseChangeUserStatusEvent(
                    itemId: itemDTO.id, token: user.token, newStatus: MyConst.ITEM_USER_STATUS_DONE));
                Navigator.of(context).pop();
              });
        } else {
          return ListTile(
              trailing: Icon(Icons.pause_circle_outline),
              title: Text("Tạm ẩn lớp, dừng đăng ký"),
              onTap: () {
                courseBloc.add(CourseChangeUserStatusEvent(
                    itemId: itemDTO.id, token: user.token, newStatus: MyConst.ITEM_USER_STATUS_INACTIVE));
                Navigator.of(context).pop();
              });
        }
    }
    return SizedBox();
  }
}
