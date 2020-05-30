import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:validators/validators.dart' as validator;

import '../blocs/account/account_bloc.dart';
import '../blocs/account/account_event.dart';
import '../blocs/account/account_state.dart';
import '../blocs/auth/auth_blocs.dart';
import '../dto/user_dto.dart';
import '../models/user_repo.dart';
import '../widgets/appbar.dart';
import 'loading.dart';

class AccountEditScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountEditScreen();
}

class _AccountEditScreen extends State<AccountEditScreen> {
  final _formKey = GlobalKey<FormState>();
  UserDTO _user;
  File _image;
  AccountBloc accountBloc;
  AuthBloc _authBloc;

  @override
  void didChangeDependencies() {
    final userRepo = RepositoryProvider.of<UserRepository>(context);
    accountBloc = AccountBloc(userRepository: userRepo);
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    super.didChangeDependencies();
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
        appBar: BaseAppBar(
          title: "Thông tin cá nhân",
        ),
        body: BlocProvider<AccountBloc>(
          create: (context) => accountBloc,
          child: BlocListener<AccountBloc, AccountState>(
            listener: (context, state) {
              if (state is AccountFailState) {
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: Text(state.error),
                ));
              }
              if (state is UploadAvatarSuccessState) {
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: Text("Cập nhật avatar thành công."),
                ));
                _authBloc..add(AuthCheckEvent());
              }
              if (state is UploadBannerSuccessState) {
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: Text("Cập nhật banner thành công."),
                ));
                _authBloc..add(AuthCheckEvent());
              }
              if (state is AccEditSaveSuccessState) {
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: Text("Cập nhật thông tin thành công."),
                ));
                _authBloc..add(AuthCheckEvent());
              }
            },
            child: BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is AccInitPageSuccess) {
                  _user = state.user;
                }
                return _user != null
                    ? Form(
                        key: _formKey,
                        child: ListView(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                              ),
                              child: Text(
                                "Chỉnh sửa thông tin cá nhân của bạn",
                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                              ),
                            ),
                            Stack(
                              children: [
                                _bannerBox(width / 3),
                                _imageBox(width / 2),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                              child: TextFormField(
                                initialValue: _user.name,
                                onSaved: (value) {
                                  setState(() {
                                    _user.name = value;
                                  });
                                },
                                validator: (String value) {
                                  if (value.length < 6) {
                                    return "Tên của bạn cần lớn hơn 6 kí tự";
                                  }
                                  _formKey.currentState.save();
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Họ & Tên",
                                  icon: Icon(MdiIcons.account),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                              child: TextFormField(
                                initialValue: _user.refcode,
                                validator: (String value) {
                                  if (value.length < 6) {
                                    return "Mã giới thiệu cần lớn hơn 6 kí tự";
                                  }
                                  _formKey.currentState.save();
                                  return null;
                                },
                                onSaved: (value) {
                                  setState(() {
                                    _user.refcode = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Mã giới thiệu của bạn",
                                  icon: Icon(MdiIcons.qrcode),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                              child: TextFormField(
                                initialValue: _user.title,
                                onSaved: (value) {
                                  setState(() {
                                    _user.title = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Chức danh",
                                  icon: Icon(MdiIcons.officeBuilding),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                              child: TextFormField(
                                initialValue: _user.introduce,
                                onSaved: (value) {
                                  setState(() {
                                    _user.introduce = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Giới thiệu ngắn",
                                  icon: Icon(MdiIcons.information),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                              child: TextFormField(
                                initialValue: _user.phone,
                                onSaved: (value) {
                                  setState(() {
                                    _user.phone = value;
                                  });
                                },
                                validator: (String value) {
                                  if (!validator.isNumeric(value)) {
                                    return "Số điện thoại không đúng";
                                  }
                                  _formKey.currentState.save();
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: "Số điện thoại",
                                  icon: Icon(MdiIcons.phone),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                              child: TextFormField(
                                initialValue: _user.email,
                                onSaved: (value) {
                                  setState(() {
                                    _user.email = value;
                                  });
                                },
                                validator: (String value) {
                                  if (!validator.isEmail(value)) {
                                    return "Email không đúng";
                                  }
                                  _formKey.currentState.save();
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
                              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                              child: TextFormField(
                                initialValue: _user.address,
                                onSaved: (value) {
                                  setState(() {
                                    _user.address = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Địa chỉ",
                                  icon: Icon(MdiIcons.map),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                              child: TextFormField(
                                initialValue: _user.country,
                                onSaved: (value) {
                                  setState(() {
                                    _user.country = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Quốc tịch",
                                  icon: Icon(MdiIcons.earth),
                                ),
                              ),
                            ),
                            Container(
                              height: 36.0,
                              margin: const EdgeInsets.all(30.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                color: Colors.blue,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    accountBloc.add(AccEditSubmitEvent(user: _user, token: _user.token));
                                  }
                                },
                                child: BlocBuilder(
                                  bloc: accountBloc,
                                  builder: (context, state) {
                                    if (state is AccEditSavingState) {
                                      return CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(Colors.white),
                                      );
                                    }
                                    return Text(
                                      "Lưu thay đổi",
                                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : LoadingScreen();
              },
            ),
          ),
        ),
      ),
    );
  }

  Future _getBanner() async {
    final File image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      accountBloc.add(AccChangeBannerEvent(token: _user.token, file: image));
    }
  }

  Future _getAvatar({bool fromCamera: false}) async {
    final File image = await ImagePicker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (image != null) {
      accountBloc.add(AccChangeAvatarEvent(token: _user.token, file: image));
    }
  }

  Widget _imageBox(double size) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10.0, left: size / 2, right: size / 2),
          child: CircleAvatar(
            backgroundColor: Colors.green,
            radius: size / 2,
            child: (_user.image != null && _user.image != "")
                ? CircleAvatar(
                    radius: size / 2 - 2.0,
                    backgroundImage: NetworkImage(
                      _user.image,
                    ),
                  )
                : Icon(Icons.account_circle),
          ),
        ),
        BlocBuilder(
          bloc: accountBloc,
          builder: (context, state) {
            if (state is UploadAvatarInprogressState) {
              return LoadingScreen();
            }
            return IconButton(
              icon: Icon(Icons.camera_alt),
              iconSize: 28.0,
              color: Colors.white,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(children: <Widget>[
                        ListTile(
                            title: Text("Chụp ảnh bằng camera"),
                            onTap: () {
                              _getAvatar(fromCamera: true);
                              Navigator.pop(context);
                            }),
                        Divider(),
                        ListTile(
                            title: Text("Chọn ảnh từ thư viện"),
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
        decoration: _user.banner != null
            ? BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_user.banner),
                  fit: BoxFit.cover,
                ),
              )
            : null,
        child: BlocBuilder(
          bloc: accountBloc,
          builder: (context, state) {
            if (state is UploadAvatarInprogressState) {
              return LoadingScreen();
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
