import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
// import 'package:html_editor/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';

import '../blocs/course/course_bloc.dart';
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
  final titleController = new TextEditingController();
  final priceController = new TextEditingController();
  final priceOrgController = new TextEditingController();
  final locationController = new TextEditingController();
  final shortController = new TextEditingController();
  final dateMask = new MaskedTextController(mask: '0000-00-00');
  final timeStartMask = new MaskedTextController(mask: '00:00');
  final timeEndMask = new MaskedTextController(mask: '00:00');
  final DateFormat f = DateFormat("yyyy-MM-dd");
  final DateFormat hf = DateFormat("HH:mm");

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
        type: MyConst.ITEM_CLASS,
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
        title: Text("Thông tin khóa học").tr(),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                _submit();
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
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text("Lưu khóa học thành công.").tr(),
              ));
            _itemDTO = new ItemDTO(
              type: MyConst.ITEM_CLASS,
            );
            Navigator.of(context).popUntil(ModalRoute.withName("/"));
            Navigator.of(context).pushNamed("/course/list");
          }
          if (state is UploadImageSuccessState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text("Cập nhật hình ảnh thành công.").tr(),
              ));
            _itemDTO!.image = state.url;
          }
        },
        child: BlocBuilder<CourseBloc, CourseState>(
          bloc: _courseBloc,
          builder: (context, state) {
            if (state is CourseLoadSuccess && _itemDTO == null) {
              _itemDTO = state.item;
              titleController.text = _itemDTO!.title;
              priceController.text = _itemDTO!.price.toString();
              priceOrgController.text = _itemDTO!.priceOrg.toString();
              shortController.text = _itemDTO!.shortContent;
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
                                    ).tr())
                                  : _imageBox(width / 2),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.length < 3) {
                                    return "Cần nhập tên khóa học tối thiểu 3 kí tự".tr();
                                  }
                                  _formKey.currentState!.save();
                                  return null;
                                },
                                controller: titleController,
                                decoration: InputDecoration(
                                  labelText: "Tên khóa học".tr(),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                controller: priceOrgController,
                                decoration: InputDecoration(
                                  labelText: "Học phí gốc".tr(),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == "") {
                                    return "Chưa nhập học phí khóa học".tr();
                                  }
                                  _formKey.currentState!.save();
                                  return null;
                                },
                                controller: priceController,
                                decoration: InputDecoration(
                                  labelText: "Học phí".tr(),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                // onTap: () {
                                //   DatePicker.showDatePicker(
                                //     context,
                                //     onConfirm: (time) {
                                //       dateMask.text = f.format(time);
                                //     },
                                //     currentTime: dateMask.text == "" ? DateTime.now() : DateTime.parse(dateMask.text),
                                //   );
                                // },
                                validator: (value) {
                                  if (value == "") {
                                    return "Chưa nhập ngày diễn ra".tr();
                                  }
                                  _formKey.currentState!.save();
                                  return null;
                                },
                                controller: dateMask,
                                decoration: InputDecoration(
                                  labelText: "Ngày diễn ra (yyyy-MM-dd)".tr(),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                // onTap: () {
                                //   DatePicker.showTimePicker(
                                //     context,
                                //     showSecondsColumn: false,
                                //     onConfirm: (timestart) {
                                //       timeStartMask.text = hf.format(timestart);
                                //     },
                                //   );
                                // },
                                controller: timeStartMask,
                                validator: (value) {
                                  if (value == "") {
                                    return "Chưa nhập giờ bắt đầu".tr();
                                  }
                                  _formKey.currentState!.save();
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Giờ bắt đầu (HH:mm)".tr(),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                // onTap: () {
                                //   DatePicker.showTimePicker(
                                //     context,
                                //     showSecondsColumn: false,
                                //     onConfirm: (timeend) {
                                //       timeEndMask.text = hf.format(timeend);
                                //     },
                                //   );
                                // },
                                controller: timeEndMask,
                                decoration: InputDecoration(
                                  labelText: "Giờ kết thúc".tr(),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                controller: locationController,
                                decoration: InputDecoration(
                                  labelText: "Địa điểm/Room online".tr(),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                maxLines: 3,
                                controller: shortController,
                                decoration: InputDecoration(
                                  labelText: "Giới thiệu ngắn".tr(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                              child: Text("Nội dung khóa học vui lòng cập nhật từ website").tr(),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: GradientButton(
                                height: 48,
                                title: "Lưu khóa học".tr(),
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
      _itemDTO!.title = titleController.text;
      _itemDTO!.priceOrg = priceOrgController.text != "" ? int.parse(priceOrgController.text) : 0;
      _itemDTO!.price = int.parse(priceController.text);
      _itemDTO!.dateStart = dateMask.text;
      _itemDTO!.timeStart = timeStartMask.text;
      _itemDTO!.timeEnd = timeEndMask.text;
      _itemDTO!.location = locationController.text;
      _itemDTO!.shortContent = shortController.text;

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
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      _courseBloc.add(CourseUploadImageEvent(token: user.token, image: File(image.path), itemId: _itemDTO!.id));
    }
  }
}
