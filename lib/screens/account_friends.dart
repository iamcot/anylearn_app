import 'dart:math' as math;

import '../dto/user_dto.dart';
import 'account/app_bar_with_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountFriendsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountFriendsScreen();
}

class _AccountFriendsScreen extends State<AccountFriendsScreen> {
  final UserDTO user = new UserDTO(
    name: "MC Hoài Trinh",
    refcode: "hoaitrinh",
    walletC: 100,
    walletM: 123400,
    // image: "",
    image:
        "https://scontent.fvca1-2.fna.fbcdn.net/v/t1.0-9/89712877_1076973919331440_3222915485796401152_n.jpg?_nc_cat=107&_nc_sid=7aed08&_nc_ohc=d-jXcHVpNOEAX8IU-ED&_nc_ht=scontent.fvca1-2.fna&oh=f98801f09d0720e77e524fef83f6e472&oe=5EEA3ECF",
  );
  final List<UserDTO> friends = [
    UserDTO(
      name: "Quỳnh Như",
      refcode: "1900114",
      walletC: 0,
      walletM: 0,
      role: "teacher",
      title: "Sai vặt viên của anyLearn",
      numFriends: 10,
      image:
          "https://scontent.fvca1-2.fna.fbcdn.net/v/t1.0-9/73201494_660636241128219_2126988502150152192_o.jpg?_nc_cat=101&_nc_sid=85a577&_nc_ohc=XpqEYsumrWQAX_eSsvw&_nc_ht=scontent.fvca1-2.fna&oh=9bb968ff193e0365eac2b28bf23342b1&oe=5EE9D4D6",
    ),
    UserDTO(
      name: "Thu Hương",
      refcode: "1900114",
      title: "Mrs",
      role: "school",
      walletC: 100000000,
      walletM: 0,
      numFriends: 99,
      // image: "",
      image:
          "https://scontent-hkt1-1.xx.fbcdn.net/v/t1.0-9/60308191_2209215299408976_8880796378649853952_n.jpg?_nc_cat=111&_nc_sid=85a577&_nc_ohc=tEDsDttM72kAX-FOaum&_nc_ht=scontent-hkt1-1.xx&oh=87a29dbc98ab55bdba7e59611a881433&oe=5EEC444E",
    ),
    UserDTO(
      name: "CoT",
      refcode: "1900115",
      title: "Mr handsome",
      role: "member",
      walletC: 0,
      walletM: 0,
      numFriends: 1,
      image: "",
    )
  ];

  @override
  Widget build(BuildContext context) {
    var moneyFormat = new NumberFormat("###,###,###", "vi_VN");
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          AccountAppBarWithImage(user: user),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: Text("Bạn bè của " + user.name + " (MGT: " + user.refcode + ")",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.grey[600])),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                decoration: BoxDecoration(
                    // color: Colors.grey[100],
                    ),
                child: Row(children: [
                  Icon(
                    Icons.info,
                    color: Colors.grey,
                    size: 12.0,
                  ),
                  Text(" Chạm để xem cấp duới. Giữ để xem thông tin.",
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                ])),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final itemIndex = index ~/ 2;
                if (index.isEven) {
                  return ListTile(
                    leading: friends[itemIndex].image != null && friends[itemIndex].image.isNotEmpty
                        ? CircleAvatar(
                            radius: 28,
                            backgroundColor: _roleColor(friends[itemIndex].role),
                            child: CircleAvatar(
                              radius: 27,
                              backgroundImage: NetworkImage(
                                friends[itemIndex].image,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.account_circle,
                            size: 56.0,
                            color: _roleColor(
                              friends[itemIndex].role,
                            ),
                          ),
                    title: Text(friends[itemIndex].name),
                    subtitle: friends[itemIndex].title != null ? Text(friends[itemIndex].title) : SizedBox(height: 0),
                    trailing: SizedBox(
                        width: 80.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          Text(friends[itemIndex].numFriends.toString() + " bạn "),
                          Icon(Icons.arrow_right),
                        ])),
                    onTap: () {
                      Navigator.of(context).pushNamed("/account/friends");
                    },
                    onLongPress: () {
                      Navigator.of(context).pushNamed("/account");
                    },
                  );
                }
                return Divider(
                  height: 0.0,
                );
              },
              semanticIndexCallback: (Widget widget, int localIndex) {
                if (localIndex.isEven) {
                  return localIndex ~/ 2;
                }
                return null;
              },
              childCount: math.max(0, friends.length * 2 - 1),
            ),
          ),
        ],
      ),
    );
  }

  Color _roleColor(String role) {
    switch (role) {
      case "teacher":
        return Colors.orange;
      case "school":
        return Colors.blue;
      default:
        return Colors.green;
    }
  }
}
