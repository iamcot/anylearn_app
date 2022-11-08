import 'package:anylearn/dto/profilelikecmt/post_dto.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController? controller;
  PostDTO? post;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 1,
            color: Colors.grey[300],
            thickness: 1,
          ),
          const SizedBox(height: 700),
          // if (image != null)
          //   _removable(
          //     context,
          //     _imageView(context),
          //   ),
          // if(widget.controller!=null)
          TextField(
              // controller: commentController,
              maxLines: 3,
              // selectionHeightStyle: BoxHeightStyle.tight,
              decoration: new InputDecoration(
                  hintText: 'Write a Comment',
                  hintStyle: new TextStyle(
                    color: Colors.grey,
                  ),
                  prefixIcon: InkWell(
                    child: Icon(Icons.camera_alt),
                    onTap: () {
                      // chooseImage();
                    },
                  ),
                  suffixIcon: InkWell(
                    child: Icon(
                      Icons.send,
                    ),
                    onTap: () {
                      // if (filePickedName == 'nofile') {
                      //   insertMethod();
                      //   commentController.clear();
                      //   _fleshScreen();
                      //   getCommentData();
                      // } else {
                      //   upload();
                      //   commentController.clear();
                      //   _fleshScreen();
                      //   getCommentData();
                      // }
                    },
                  )),
              style: new TextStyle(
                color: Colors.black,
              ),
              
            ),
        ],
      ),
    );
  }
}
