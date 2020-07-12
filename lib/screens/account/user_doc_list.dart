import 'package:anylearn/customs/custom_cached_image.dart';
import 'package:anylearn/dto/user_doc_dto.dart';
import 'package:flutter/material.dart';

class UserDocList extends StatelessWidget {
  final List<UserDocDTO> userDocs;

  const UserDocList({Key key, this.userDocs}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print(width);
    return Container(
      height: (userDocs.length / 3).ceil().toDouble() * (width / 3),
      child: GridView.builder(
        itemCount: userDocs.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  child: SimpleDialog(
                    children: <Widget>[
                      CustomCachedImage(url: userDocs[index].data),
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Đóng"))
                    ],
                  ));
            },
            child: Card(
                elevation: 0,
                child: CustomCachedImage(
                  url: userDocs[index].data,
                )),
          );
        },
      ),
    );
  }
}
