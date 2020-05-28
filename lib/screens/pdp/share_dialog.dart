import 'package:flutter/material.dart';
import 'package:share/share.dart';

class PdpShareDialog extends StatelessWidget {
  final itemId;

  const PdpShareDialog({Key key, this.itemId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: <Widget>[
      ListTile(title: Text("Chia sẻ tới bạn bè trong hệ thống"), onTap: () {}),
      Divider(),
      ListTile(
          title: Text("Chia sẻ ra mạng xã hội"),
          onTap: () {
            Share.share("Khóa học hay trên anyLEARN bạn có biết chưa https://anylearn.vn/course/" + itemId.toString());
          }),
    ]);
  }
}
