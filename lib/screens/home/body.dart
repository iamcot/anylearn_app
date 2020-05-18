import 'dart:ui';

import 'package:anylearn/widgets/account_icon.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          actions: <Widget>[
            AccountIcon(),
          ],
          flexibleSpace: LayoutBuilder(
            builder: (context, bc) {
              return FlexibleSpaceBar(
                centerTitle: false,
                background: new ClipRect(
                  child: new Container(
                    child: new BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: new Container(
                        decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    decoration: new BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "images/bg.png",
                            ),
                            fit: BoxFit.fitWidth)),
                  ),
                ),
              );
            },
          ),
        ),
        SliverList(
          //
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                title: Text("Text"),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    ));
  }
}
