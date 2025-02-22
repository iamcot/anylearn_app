import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_html_editor/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:validators/validators.dart' as validator;

import '../blocs/account/account_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../customs/feedback.dart';
import '../dto/const.dart';
import '../dto/user_dto.dart';
import '../models/user_repo.dart';
import '../widgets/loading_widget.dart';

class AccountEditScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountEditScreen();
}

class _AccountEditScreen extends State<AccountEditScreen> {
  final _formKey = GlobalKey<FormState>();
  UserDTO _user = UserDTO();
  //late File _image;
  late AccountBloc accountBloc;
  late AuthBloc _authBloc;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userRepo = RepositoryProvider.of<UserRepository>(context);
    accountBloc = AccountBloc(userRepository: userRepo);
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent(isFull: true));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AuthFailState) {
          Navigator.of(context).popUntil(ModalRoute.withName("/"));
        }
        if (state is AuthSuccessState) {
          accountBloc..add(AccInitPageEvent(user: state.user));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("Thông tin cá nhân").tr(),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // _user.fullContent = "";
                    accountBloc..add(AccEditSubmitEvent(user: _user, token: _user.token));
                  }
                })
          ],
        ),
        body: BlocProvider<AccountBloc>(
          create: (context) => accountBloc,
          child: BlocListener<AccountBloc, AccountState>(
            bloc: accountBloc,
            listener: (context, state) {
              if (state is AccountFailState) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(state.error),
                  ));
              }
              if (state is UploadAvatarSuccessState) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text("Cập nhật avatar thành công.").tr(),
                  ));
                _authBloc..add(AuthCheckEvent());
              }
              if (state is UploadBannerSuccessState) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text("Cập nhật banner thành công.").tr(),
                  ));
                _authBloc..add(AuthCheckEvent());
              }
              if (state is AccEditSaveSuccessState) {
                _authBloc..add(AuthCheckEvent());
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text("Cập nhật thông tin thành công.").tr(),
                  )).closed.then((value) {
                    Navigator.of(context).pop();
                  });
              }
            },
            child: BlocBuilder<AccountBloc, AccountState>(
              bloc: accountBloc,
              builder: (context, state) {
                if (state is AccInitPageSuccess) {
                  _user = state.user;
                }
                return _user.token != ""
                    ? CustomFeedback(
                        user: _user,
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                ),
                                child: Text(
                                  "Chỉnh sửa thông tin cá nhân của bạn",
                                  style:
                                      TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                                ).tr(),
                              ),
                              Stack(
                                children: [
                                  _bannerBox(width / 2),
                                  _imageBox(width / 3),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  initialValue: _user.name,
                                  onSaved: (value) {
                                    setState(() {
                                      // _user.name = value!;
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.length < 3) {
                                      return "Tên của bạn cần lớn hơn 3 kí tự".tr();
                                    }
                                    _formKey.currentState!.save();
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Họ & Tên".tr(),
                                    icon: Icon(MdiIcons.account),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  initialValue: _user.refcode,
                                  validator: (value) {
                                    if (value!.length < 6) {
                                      return "Mã giới thiệu cần lớn hơn 6 kí tự".tr();
                                    }
                                    _formKey.currentState!.save();
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      // _user.refcode = value!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Mã giới thiệu của bạn".tr(),
                                    icon: Icon(MdiIcons.qrcode),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  initialValue: _user.title,
                                  onSaved: (value) {
                                    setState(() {
                                      // _user.title = value!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Chức danh".tr() +
                                        (_user.role == MyConst.ROLE_SCHOOL ? " & Tên người đại diện".tr() : ""),
                                    icon: Icon(MdiIcons.officeBuilding),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  initialValue: _user.phone,
                                  onSaved: (value) {
                                    setState(() {
                                      // _user.phone = value!;
                                    });
                                  },
                                  validator: (value) {
                                    if (!validator.isNumeric(value!)) {
                                      return "Số điện thoại không đúng".tr();
                                    }
                                    _formKey.currentState!.save();
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    labelText: "Số điện thoại".tr(),
                                    icon: Icon(MdiIcons.phone),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  initialValue: _user.email,
                                  onSaved: (value) {
                                    setState(() {
                                      // _user.email = value!;
                                    });
                                  },
                                  validator: (value) {
                                    if (!validator.isEmail(value!)) {
                                      return "Email không đúng".tr();
                                    }
                                    _formKey.currentState!.save();
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    icon: Icon(MdiIcons.email),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  initialValue: _user.address,
                                  onSaved: (value) {
                                    setState(() {
                                      // _user.address = value!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Địa chỉ".tr(),
                                    icon: Icon(MdiIcons.map),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  initialValue: _user.country,
                                  onSaved: (value) {
                                    setState(() {
                                      // _user.country = value!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Quốc gia".tr(),
                                    icon: Icon(MdiIcons.earth),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                child: TextFormField(
                                  maxLines: 3,
                                  initialValue: _user.introduce,
                                  onSaved: (value) {
                                    setState(() {
                                      // _user.introduce = value!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Giới thiệu ngắn".tr(),
                                    icon: Icon(MdiIcons.information),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
                                child: Text("Thông tin giới thiệu vui lòng cập nhật từ website").tr(),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15),
                              //   child: HtmlEditor(
                              //     // hint: "Thông tin giới thiệu",
                              //     value: _user.fullContent ?? "",
                              //     key: keyEditor,
                              //     height: 400,
                              //     showBottomToolbar: true,
                              //   ),

                              // ),
                              Container(
                                height: 48.0,
                                margin: const EdgeInsets.all(15.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      // _user.fullContent = ""; //await keyEditor.currentState.getText();
                                      _formKey.currentState!.save();
                                      accountBloc..add(AccEditSubmitEvent(user: _user, token: _user.token));
                                    }
                                  },
                                  child: BlocBuilder(
                                    bloc: accountBloc,
                                    builder: (context, state) {
                                      if (state is AccEditSavingState) {
                                        return LoadingWidget();
                                      }
                                      return Text(
                                        "Lưu thay đổi",
                                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                                      ).tr();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : LoadingWidget();
              },
            ),
          ),
        ),
      ),
    );
  }

  Future _getBanner() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      accountBloc..add(AccChangeBannerEvent(token: _user.token, file: File(image.path)));
    }
  }

  Future _getAvatar({bool fromCamera = false}) async {
    final XFile? image = await _imagePicker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (image != null) {
      accountBloc..add(AccChangeAvatarEvent(token: _user.token, file: File(image.path)));
    }
  }

  Widget _imageBox(double size) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: size, left: size, right: size),
          child: CircleAvatar(
            backgroundColor: Colors.green,
            radius: size / 2,
            child: (_user.image != "")
                ? CircleAvatar(
                    radius: size / 2 - 2.0,
                    backgroundImage: CachedNetworkImageProvider(_user.image),
                  )
                : Icon(Icons.account_circle),
          ),
        ),
        BlocBuilder(
          bloc: accountBloc,
          builder: (context, state) {
            if (state is UploadAvatarInprogressState) {
              return LoadingWidget();
            }
            return IconButton(
              icon: Icon(Icons.camera_alt),
              iconSize: 28.0,
              color: Colors.grey,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(children: <Widget>[
                        ListTile(
                            title: Text("Chụp ảnh bằng camera").tr(),
                            onTap: () {
                              _getAvatar(fromCamera: true);
                              Navigator.pop(context);
                            }),
                        Divider(),
                        ListTile(
                            title: Text("Chọn ảnh từ thư viện").tr(),
                            onTap: () {
                              _getAvatar(fromCamera: false);
                              Navigator.pop(context);
                            }),
                      ]);
                    });
              },
            );
          },
        ),
      ],
    );
  }

  Widget _bannerBox(double size) {
    return Container(
        height: size,
        width: double.infinity,
        alignment: Alignment.bottomRight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(_user.banner),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocBuilder(
          bloc: accountBloc,
          builder: (context, state) {
            if (state is UploadBannerInprogressState) {
              return LoadingWidget();
            }
            return IconButton(
              icon: Icon(Icons.camera_alt),
              iconSize: 28.0,
              color: Colors.grey,
              onPressed: () {
                _getBanner();
              },
            );
          },
        ));
  }
}
