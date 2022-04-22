import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/screens/pdp/course_share.dart';
import 'package:flutter/material.dart';

class PdpShareDialog extends StatelessWidget {
  final item;
  final user;
  final pdpBloc;

  const PdpShareDialog({key, this.item, this.user, this.pdpBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: <Widget>[
      ListTile(
          title: Text("Chia sẻ tới bạn bè trong cộng đồng"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CourseShareScreen(
                      user: user,
                      pdpBloc: pdpBloc,
                      pdpId: item.id,
                    )));
          }),
      Divider(),
      ListTile(
          title: Text("Chia sẻ ra mạng xã hội"),
          onTap: () {
            // Share.share(item.url);
          }),
    ]);
  }
}
