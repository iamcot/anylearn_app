import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../customs/custom_cached_image.dart';
import '../dto/user_dto.dart';
import '../screens/webview.dart';

class UserQuickProfile extends StatelessWidget {
  final UserDTO user;

  const UserQuickProfile({required this.user});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double imgHeight = width - 50;
    double height = width + 100;
    return SliverToBoxAdapter(
      child: Container(
          padding: EdgeInsets.all(10),
          child: Card(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: imgHeight,
                  width: imgHeight,
                  padding: EdgeInsets.all(25),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(imgHeight / 2),
                    child: user.image != null ? CustomCachedImage(url: user.image) : Icon(Icons.broken_image),
                  ),
                ),
                Container(
                  child: Text(
                    user.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    user.introduce,
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    textAlign: TextAlign.justify,
                  ),
                ),
                user.fullContent == null
                    ? Container()
                    : Container(
                        child: ExpandableNotifier(
                          child: ScrollOnExpand(
                            child: Expandable(
                              collapsed: Column(
                                children: [
                                  ExpandableButton(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                      margin: EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(18),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(0, 2), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        "XEM THÊM",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              expanded: Column(children: [
                                Html(
                                  data: user.fullContent,
                                  shrinkWrap: true,
                                  onLinkTap: (url, _, __, ___) {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => WebviewScreen(
                                              url: url!,
                                            )));
                                  },
                                ),
                                ExpandableButton(child: Container(
                                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                      margin: EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(18),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(0, 2), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        "THU GỌN",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )),
                              ]),
                            ),
                          ),
                        ),
                      )
              ],
            ),
          )),
    );
  }
}
