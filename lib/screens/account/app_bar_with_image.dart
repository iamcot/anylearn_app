import 'package:anylearn/dto/user_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
            title: Text(
              user.name,
              style: TextStyle(),
            ),
            background: new ClipRect(
              child: new Container(
                decoration: new BoxDecoration(
                  image: user.image != null
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(user.image),
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        )
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
