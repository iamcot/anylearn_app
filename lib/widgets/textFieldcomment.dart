import 'package:anylearn/dto/profilelikecmt/post_dto.dart';
import 'package:anylearn/widgets/postcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFieldComment extends StatefulWidget {
  const TextFieldComment({Key? key}) : super(key: key);

  @override
  State<TextFieldComment> createState() => _TextFieldCommentState();
}

class _TextFieldCommentState extends State<TextFieldComment> {
  TextEditingController? controller;
  PostDTO? post;
  @override
  void initState() {
    controller = post?.comments as TextEditingController?;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          // maxLines: 3,
          decoration: new InputDecoration(
              hintText: 'Write a Comment',
              hintStyle: new TextStyle(
                color: Colors.grey,
              ),
              prefixIcon: InkWell(
                child: Icon(Icons.camera_alt),
                onTap: () {},
              ),
              suffixIcon: InkWell(
                child: Icon(
                  Icons.send,
                ),
                onTap: () {},
              )),
          style: new TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
