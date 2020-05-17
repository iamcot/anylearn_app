import 'package:anylearn/widgets/account_icon.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 120.0,
          floating: false,
          pinned: true,
          actions: <Widget>[
            AccountIcon(),
          ],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(15.0),
            centerTitle: true,

            title: Container(
              child: Image.network(
                "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                fit: BoxFit.cover,
              ),
            ),
            // title: Text("Collapsing Toolbar",
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 16.0,
            //     )),
            // background: Image.network(
            //   "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
            //   fit: BoxFit.cover,
            // ),
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
