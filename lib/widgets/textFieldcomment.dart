import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/account/account_blocs.dart';
import '../dto/const.dart';
import '../dto/profilelikecmt/post_dto.dart';
import '../main.dart';

class TextFieldComment extends StatefulWidget {
  const TextFieldComment({Key? key}) : super(key: key);

  @override
  State<TextFieldComment> createState() => _TextFieldCommentState();
}

class _TextFieldCommentState extends State<TextFieldComment> {
  TextEditingController? controller;
  PostDTO? post;
  late AccountBloc _accountBloc;
  @override
  void initState() {
    controller = post?.comments as TextEditingController?;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _accountBloc = BlocProvider.of<AccountBloc>(context);
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
                onTap: () {
                  _accountBloc
                    ..add(ActionUserEvent(
                        content: controller!.text = "",
                        token: user.token,
                        type: MyConst.TYPE_ACTION_COMMENT,
                        id: post!.id));
                },
              )),
          style: new TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
