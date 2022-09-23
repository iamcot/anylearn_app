import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
// import 'package:html_editor/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';

import '../blocs/course/course_blocs.dart';
import '../customs/feedback.dart';
import '../dto/const.dart';
import '../dto/item_dto.dart';
import '../main.dart';
import '../models/item_repo.dart';
import '../models/user_repo.dart';
import '../widgets/gradient_button.dart';
import '../widgets/loading_widget.dart';

class CourseFormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CourseFormScreen();
}

class _CourseFormScreen extends State<CourseFormScreen> {
  // GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  final dateMask = new MaskedTextController(mask: '0000-00-00');
  final timeStartMask = new MaskedTextController(mask: '00:00');
  final timeEndMask = new MaskedTextController(mask: '00:00');
  final DateFormat f = DateFormat("yyyy-MM-dd");

  late CourseBloc _courseBloc;
  ItemDTO? _itemDTO;
  int editId = 0;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void didChangeDependencies() {
    if (user.token == "") {
      Navigator.of(context).popAndPushNamed("/login");
    }
    // if (user.updateDoc == 0) {
    //   Navigator.of(context).pushNamed("/account/docs", arguments: user.token);
    // }
    // if (user.isSigned < MyConst.CONTRACT_SIGNED) {
    //   Navigator.of(context).pushNamed("/contract/" + user.role);
    // }
    try {
      editId = int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    } catch (e) {
      editId = 0;
    }
    final itemRepo = RepositoryProvider.of<ItemRepository>(context);
    final userRepo = RepositoryProvider.of<UserRepository>(context);
    _courseBloc = CourseBloc(itemRepository: itemRepo, userRepository: userRepo);

    if (editId > 0) {
      _courseBloc..add(LoadCourseEvent(id: editId, token: user.token));
    } else {
      _itemDTO = new ItemDTO(
        type: MyConst.ITEM_COURSE,
      );
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    editId = 0;
    _itemDTO = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin khóa học"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _itemDTO!.content = ""; // await keyEditor.currentState.getText();
                  _courseBloc..add(SaveCourseEvent(item: _itemDTO!, token: user.token));
                }
              })
        ],
      ),
      body: BlocListener<CourseBloc, CourseState>(
        bloc: _courseBloc,
        listener: (context, state) {
          if (state is CourseFailState) {
            toast(state.error);
          }
          if (state is CourseSaveSuccessState) {
            toast("Lưu khóa học thành công.");
            _itemDTO = new ItemDTO(
              type: MyConst.ITEM_COURSE,
            );
            Navigator.of(context).popUntil(ModalRoute.withName("/"));
            Navigator.of(context).pushNamed("/course/list");
          }
          if (state is UploadImageSuccessState) {
            toast("Cập nhật hình ảnh thành công.");
            _itemDTO!.image = state.url;
          }
        },
        child: BlocBuilder<CourseBloc, CourseState>(
          bloc: _courseBloc,
          builder: (context, state) {
            if (state is CourseLoadSuccess) {
              _itemDTO = state.item;
              dateMask.text = _itemDTO!.dateStart;
              timeStartMask.text = _itemDTO!.timeStart;
              timeEndMask.text = _itemDTO!.timeEnd;
            }

            return _itemDTO != null
                ? CustomFeedback(
                    user: user,
                    child: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: _itemDTO!.id == 0
                                  ? Container(
                                      child: Text(
                                      "Sẽ cập nhật được ảnh đại diện khóa học sau khi tạo thành công",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ))
                                  : _imageBox(width / 2),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.length < 3) {
                                    return "Cần nhập tên khóa học tối thiểu 3 kí tự";
                                  }
                                  _formKey.currentState!.save();
                                  return null;
                                },
                                initialValue: _itemDTO!.title,
                                onChanged: (value) {
                                  setState(() {
                                    _itemDTO!.title = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Tên khóa học",
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    if (value != "") {
                                      _itemDTO!.priceOrg = int.parse(value);
                                    }
                                  });
                                },
                                initialValue: _itemDTO!.priceOrg.toString(),
                                decoration: InputDecoration(
                                  labelText: "Học phí gốc",
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == "") {
                                    return "Chưa nhập học phí khóa học";
                                  }
                                  _formKey.currentState!.save();
                                  return null;
                                },
                                initialValue: _itemDTO!.price.toString(),
                                onChanged: (value) {
                                  setState(() {
                                    if (value != "") {
                                      _itemDTO!.price = int.parse(value);
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Học phí",
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                onTap: () {
                                  DatePicker.showDatePicker(
                                    context,
                                    onConfirm: (time) {
                                      dateMask.text = f.format(time);
                                    },
                                    currentTime: dateMask.text == "" ? DateTime.now() : DateTime.parse(dateMask.text),
                                  );
                                },
                                validator: (value) {
                                  if (value == "") {
                                    return "Chưa nhập ngày diễn ra";
                                  }
                                  _formKey.currentState!.save();
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _itemDTO!.dateStart = value;
                                  });
                                },
                                controller: dateMask,
                                decoration: InputDecoration(
                                  labelText: "Ngày diễn ra (yyyy-MM-dd)",
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    _itemDTO!.timeStart = value;
                                  });
                                },
                                controller: timeStartMask,
                                validator: (value) {
                                  try {
                                    {
                                      _formKey.currentState!.save();
                                      return null;
                                    }
                                  } catch (error) {
                                    if (value == "") {
                                      return "Chưa nhập giờ bắt đầu";
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: "Giờ bắt đầu (HH:mm)",
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    _itemDTO!.timeEnd = value;
                                  });
                                },
                                controller: timeEndMask,
                                decoration: InputDecoration(
                                  labelText: "Giờ kết thúc",
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    _itemDTO!.location = value;
                                  });
                                },
                                initialValue: _itemDTO!.location,
                                decoration: InputDecoration(
                                  labelText: "Địa điểm/Room online",
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                maxLines: 3,
                                onChanged: (value) {
                                  setState(() {
                                    _itemDTO!.shortContent = value;
                                  });
                                },
                                initialValue: _itemDTO!.shortContent,
                                decoration: InputDecoration(
                                  labelText: "Giới thiệu ngắn",
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                              child: Text("Nội dung khóa học vui lòng cập nhật từ website"),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: GradientButton(
                                height: 48,
                                title: "Lưu khóa học",
                                function: () {
                                  _submit();
                                },
                              ),
                            ),
                          ],
                        )),
                  )
                : LoadingWidget();
          },
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _itemDTO!.content = ""; //await keyEditor.currentState.getText();
      _courseBloc.add(SaveCourseEvent(item: _itemDTO!, token: user.token));
    }
  }

  Widget _imageBox(double size) {
    return Container(
        height: size,
        width: size,
        alignment: Alignment.bottomRight,
        decoration: _itemDTO!.image != ""
            ? BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(_itemDTO!.image),
                  fit: BoxFit.scaleDown,
                ),
              )
            : null,
        child: BlocBuilder(
          bloc: _courseBloc,
          builder: (context, state) {
            if (state is UploadImageInprogressState) {
              return LoadingWidget();
            }
            return IconButton(
              icon: Icon(Icons.camera_alt),
              iconSize: 28.0,
              color: Colors.grey,
              onPressed: () {
                _getImage();
              },
            );
          },
        ));
  }

  Future _getImage() async {
    final PickedFile? image = await _imagePicker.getImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      _courseBloc.add(CourseUploadImageEvent(token: user.token, image: File(image.path), itemId: _itemDTO!.id));
    }
  }
}
