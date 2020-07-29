import 'package:anylearn/screens/pdp/course_share.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class PdpShareDialog extends StatelessWidget {
  final itemId;
  final user;
  final pdpBloc;

  const PdpShareDialog({Key key, this.itemId, this.user, this.pdpBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: <Widget>[
      ListTile(
          title: Text("Chia sẻ tới bạn bè trong hệ thống"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CourseShareScreen(
                      user: user,
                      pdpBloc: pdpBloc,
                      pdpId: itemId,
                    )));
          }),
      // Divider(),
      // ListTile(
      //     title: Text("Chia sẻ ra mạng xã hội"),
      //     onTap: () {
      //       Share.share("Khóa học hay trên anyLEARN bạn có biết chưa https://anylearn.vn/course/" + itemId.toString());
      //     }),
    ]);
  }
}
