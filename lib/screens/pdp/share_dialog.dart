import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/screens/pdp/course_share.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class PdpShareDialog extends StatelessWidget {
  final item;
  final user;
  final pdpBloc;

  const PdpShareDialog({key, this.item, this.user, this.pdpBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
        Text('title').tr();

    return SimpleDialog(children: <Widget>[
      ListTile(
          title: Text("Chia sẻ tới bạn bè trong cộng đồng"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CourseShareScreen(
                      pdpBloc: pdpBloc,
                      pdpId: item.id,
                    )));
          }),
      Divider(),
      ListTile(
          title: Text("Chia sẻ ra mạng xã hội"),
          onTap: () {
            Share.share(item.url);
          }),
    ]);
  }
}
