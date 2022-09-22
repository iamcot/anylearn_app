import 'package:anylearn/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/article/article_blocs.dart';
import '../dto/const.dart';
import '../widgets/gradient_button.dart';

class AskFormScreen extends StatefulWidget {
  final askId;
  final askBloc;
  final type;

  AskFormScreen({this.askId, this.askBloc, this.type});

  @override
  State<StatefulWidget> createState() => _AskFormScreen();
}

class _AskFormScreen extends State<AskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
        Text('title').tr();

    return Scaffold(
      appBar: AppBar(
        title: Text("Gửi " + _buildText(widget.type)),
        centerTitle: false,
      ),
      body: BlocListener<ArticleBloc, ArticleState>(
        bloc: widget.askBloc,
        listener: (context, state) {
          if (state is AskCreateSuccessState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text("Đã gửi thành công."),
              )).closed.then((value) {
                Navigator.of(context).pop(true);
              });
          }
          if (state is AskCreateFailState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(state.error.toString()),
              ));
          }
        },
        child: Container(
          padding: EdgeInsets.all(8),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.type == MyConst.ASK_QUESTION
                      ? TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: "Tiêu đề",
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10),
                    child: Text("Nội dung " + _buildText(widget.type)),
                  ),
                  TextField(
                    controller: _contentController,
                    minLines: 5,
                    maxLines: 8,
                  ),
                  (widget.type == MyConst.ASK_COMMENT || widget.type == MyConst.ASK_QUESTION)
                      ? SizedBox(
                          height: 0,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 10),
                          child: Text("Nếu bạn đã trả lời, trả lời mới sẽ cập nhật nội dung trả lời cũ."),
                        ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: BlocBuilder<ArticleBloc, ArticleState>(
                        bloc: widget.askBloc,
                        builder: (context, state) {
                          if (state is AskCreateLoadingState) {
                            return Container(width: 50.0, child: CircularProgressIndicator());
                          }
                          return GradientButton(
                            height: 48,
                            title: "Gửi " + _buildText(widget.type),
                            function: () {
                              _submit();
                            },
                          );
                        }),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.askBloc.add(AskCreateEvent(
        askId: widget.askId,
        title: widget.type == MyConst.ASK_QUESTION ? _titleController.text : "",
        type: widget.type,
        user: user,
        content: _contentController.text,
      ));
    }
  }

  String _buildText(String type) {
    switch (type) {
      case MyConst.ASK_QUESTION:
        return "câu hỏi";
      case MyConst.ASK_ANSWER:
        return "trả lời";
      case MyConst.ASK_COMMENT:
        return "bình luận";
    }
    return "";
  }
}
