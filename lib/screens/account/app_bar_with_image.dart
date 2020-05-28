import 'package:anylearn/dto/user_dto.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AccountAppBarWithImage extends StatelessWidget {
  final UserDTO user;

  const AccountAppBarWithImage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double barHeight = width * 3 / 5;
    return SliverAppBar(
      expandedHeight: user.image != null ? barHeight : 0,
      centerTitle: true,
      floating: true,
      pinned: user.image != null ? false : true,
      actions: <Widget>[
        IconButton(
            icon: Icon(MdiIcons.qrcodeScan),
            onPressed: () {
              Navigator.of(context).pushNamed("/qrcode");
            })
      ],
      flexibleSpace: LayoutBuilder(
        builder: (context, bc) {
          return FlexibleSpaceBar(
            centerTitle: false,
            title: Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              decoration: user.image != null
                  ? BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.black38,
                    )
                  : null,
              child: Text(
                user.name,
                style: TextStyle(),
              ),
            ),
            background: new ClipRect(
              child: new Container(
                decoration: new BoxDecoration(
                  image: user.image != null
                      ? DecorationImage(
                          image: NetworkImage(user.image), fit: BoxFit.cover, alignment: Alignment.topCenter)
                      : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
