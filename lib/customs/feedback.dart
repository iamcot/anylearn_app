import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../blocs/feedback/feedback_blocs.dart';
import '../dto/user_dto.dart';
import '../models/page_repo.dart';

class CustomFeedback extends StatefulWidget {
  final Widget child;
  final UserDTO user;
  const CustomFeedback({Key key, this.child, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomFeedback();
}

class _CustomFeedback extends State<CustomFeedback> {
  final disableFeedback = false;
  final _formKey = new GlobalKey<FormState>();
  GlobalKey previewContainer = new GlobalKey();
  FeedbackBloc feedbackBloc;
  String content;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final PageRepository pageRepository = RepositoryProvider.of<PageRepository>(context);
    feedbackBloc = FeedbackBloc(pageRepository: pageRepository);
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: previewContainer,
      child: BlocProvider<FeedbackBloc>(
        create: (context) => feedbackBloc,
        child: BlocListener<FeedbackBloc, FeedbackState>(
          listener: (context, state) {
            if (state is FeedbackSuccessState) {
              Scaffold.of(context).showSnackBar(new SnackBar(content: Text("Cảm ơn bạn đã góp ý cho chúng tôi.")));
            }
          },
          child: Container(
            color: Colors.white,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                widget.child,
                disableFeedback || widget.user == null
                    ? SizedBox(
                        height: 0,
                      )
                    : Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(bottom: 20),
                        child: FloatingActionButton(
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                        titlePadding: EdgeInsets.all(10),
                                        title: Text(
                                          "anyLEARN luôn hoàn thiện từng ngày để phục vụ bạn tốt hơn, hãy nhắn cho chúng tôi 1 thông tin phản hồi về trải nghiệm của bạn!",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        children: <Widget>[
                                          Form(
                                            key: _formKey,
                                            child: TextFormField(
                                              validator: (String value) {
                                                if (value.length < 3) {
                                                  return "Bạn chưa nhập phản hồi nè.";
                                                }
                                                _formKey.currentState.save();
                                                return null;
                                              },
                                              maxLines: 8,
                                              onChanged: (value) {
                                                setState(() {
                                                  content = value;
                                                });
                                              },
                                              initialValue: "",
                                              decoration: InputDecoration(
                                                  alignLabelWithHint: true,
                                                  labelText: "Để lại ý kiến đóng góp của bạn vào đây..",
                                                  labelStyle: TextStyle(fontSize: 14)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                                            child: Row(children: [
                                              Icon(
                                                Icons.info,
                                                color: Colors.blue,
                                              ),
                                              // Image.file(await takeScreenShot()),
                                              Expanded(
                                                  child: Text(
                                                "Để hiểu rõ hơn ý kiến của bạn, chúng tôi xin phép được chụp màn hình ứng dụng của bạn.",
                                                style: TextStyle(fontSize: 12, color: Colors.black87),
                                              )),
                                            ]),
                                          ),
                                          RaisedButton(
                                            // padding: EdgeInsets.all(10),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                side: BorderSide(color: Colors.blueAccent)),
                                            onPressed: () async {
                                              if (_formKey.currentState.validate()) {
                                                _formKey.currentState.save();
                                                Navigator.of(context).pop();
                                                Future.delayed(const Duration(seconds: 5));
                                                final file = await takeScreenShot();
                                                feedbackBloc
                                                  ..add(SaveFeedbackEvent(
                                                    file: file,
                                                    token: widget.user.token,
                                                    content: content,
                                                  ));
                                              }
                                            },
                                            color: Colors.blue,
                                            child: Text(
                                              "Gửi phản hồi",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ));
                            },
                            child: Icon(Icons.add_comment))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<File> takeScreenShot() async {
    try {
      RenderRepaintBoundary boundary = previewContainer.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      File file = new File("$directory/screenshot.png");
      await file.writeAsBytes(pngBytes);
      return file;
    } catch (e) {}
    return null;
  }
}
