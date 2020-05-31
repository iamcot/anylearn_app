import 'package:anylearn/dto/const.dart';
import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/models/item_repo.dart';
import 'package:anylearn/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../blocs/auth/auth_blocs.dart';
import '../blocs/course/course_blocs.dart';

class CourseFormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CourseFormScreen();
}

class _CourseFormScreen extends State<CourseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final dateMask = new MaskedTextController(mask: '0000-00-00');
  final timeStartMask = new MaskedTextController(mask: '00:00');
  final timeEndMask = new MaskedTextController(mask: '00:00');
  AuthBloc _authBloc;
  CourseBloc _courseBloc;
  ItemDTO _itemDTO;
  int editId;
  UserDTO _user;

  @override
  void didChangeDependencies() {
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    _courseBloc = CourseBloc(itemRepository: RepositoryProvider.of<ItemRepository>(context));
    editId = ModalRoute.of(context).settings.arguments;
    if (editId == null) {
      _itemDTO = new ItemDTO(
        type: MyConst.ITEM_COURSE,
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AuthFailState) {
          Navigator.of(context).popAndPushNamed("/login");
        }
        if (state is AuthSuccessState) {
          _user = state.user;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Thông tin khóa học"),
          centerTitle: false,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.menu), onPressed: () {
              Navigator.of(context).popAndPushNamed("/account/calendar");
            }),
          ],
        ),
        body: BlocProvider<CourseBloc>(
          create: (context) => _courseBloc,
          child: BlocListener<CourseBloc, CourseState>(listener: (context, state) {
            if (state is CourseFailState) {
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: Text(state.error.toString()),
              ));
            }
            if (state is CourseSaveSuccessState) {
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: Text("Lưu khóa học thành công."),
              ));
            }
          }, child: BlocBuilder<CourseBloc, CourseState>(
            builder: (context, state) {
              if (state is CourseLoadSuccess) {
                _itemDTO = state.item;
              }
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        _itemDTO == null || _itemDTO.id == null
                            ? Container(
                                child: Text(
                                "Sẽ cập nhật được ảnh đại diện khóa học sau khi tạo thành công",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ))
                            : Container(child: Text("")),
                        TextFormField(
                          validator: (String value) {
                            if (value.length < 10) {
                              return "Cần nhập tên khóa học tối thiểu 10 kí tự";
                            }
                            _formKey.currentState.save();
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _itemDTO.title = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Tên khóa học",
                          ),
                        ),
                        TextFormField(
                           validator: (String value) {
                            if (value == "") {
                              return "Chưa nhập học phí khóa học";
                            }
                            _formKey.currentState.save();
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _itemDTO.price = int.tryParse(value);
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Học phí",
                          ),
                        ),
                        TextFormField(
                          onSaved: (value) {
                            setState(() {
                              _itemDTO.priceOrg = int.tryParse(value);
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Học phí gốc",
                          ),
                        ),
                        TextFormField(
                           validator: (String value) {
                            if (value == "") {
                              return "Chưa nhập ngày diễn ra";
                            }
                            _formKey.currentState.save();
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _itemDTO.dateStart = value;
                            });
                          },
                          controller: dateMask,
                          decoration: InputDecoration(
                            labelText: "Ngày diễn ra (yyyy-MM-dd)",
                          ),
                        ),
                        TextFormField(
                          onSaved: (value) {
                            setState(() {
                              _itemDTO.timeStart = value;
                            });
                          },
                          controller: timeStartMask,
                           validator: (String value) {
                            if (value == "") {
                              return "Chưa nhập giờ bắt đầu";
                            }
                            _formKey.currentState.save();
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Giờ bắt đầu (HH:mm)",
                          ),
                        ),
                        TextFormField(
                          onSaved: (value) {
                            setState(() {
                              _itemDTO.timeEnd = value;
                            });
                          },
                          controller: timeEndMask,
                          decoration: InputDecoration(
                            labelText: "Giờ kết thúc",
                          ),
                        ),
                        TextFormField(
                          onSaved: (value) {
                            setState(() {
                              _itemDTO.location = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Địa điểm/Room online",
                          ),
                        ),
                        TextFormField(
                          maxLines: 3,
                          onSaved: (value) {
                            setState(() {
                              _itemDTO.shortContent = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Giới thiệu ngắn",
                          ),
                        ),
                        TextFormField(
                          maxLines: 8,
                          onSaved: (value) {
                            setState(() {
                              _itemDTO.content = value;
                            });
                          },
                           validator: (String value) {
                            if (value == "") {
                              return "Chưa nhập giới thiệu khóa học";
                            }
                            _formKey.currentState.save();
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Nội dung khóa học",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: GradientButton(
                            title: "Lưu khóa học",
                            function: () {
                              _submit();
                            },
                          ),
                        ),
                      ],
                    )),
              );
            },
          )),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _courseBloc.add(SaveCourseEvent(item: _itemDTO, token: _user.token));
    }
  }
}
