import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:validators/validators.dart' as validator;

import '../dto/user_dto.dart';
import '../widgets/appbar.dart';

class AccountEditScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountEditScreen();
}

class _AccountEditScreen extends State<AccountEditScreen> {
  final _formKey = GlobalKey<FormState>();
  UserDTO _user = new UserDTO(
    name: "IamCoT",
    refcode: "iamcot",
    phone: "1900113",
    email: "t@g.c",
    title: "Mr",
    image:
        "https://scontent.fvca1-2.fna.fbcdn.net/v/t1.0-9/89712877_1076973919331440_3222915485796401152_n.jpg?_nc_cat=107&_nc_sid=7aed08&_nc_ohc=d-jXcHVpNOEAX8IU-ED&_nc_ht=scontent.fvca1-2.fna&oh=f98801f09d0720e77e524fef83f6e472&oe=5EEA3ECF",
  );
  File _image;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments != null) {
      _user = ModalRoute.of(context).settings.arguments;
    }
    double width = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      appBar: BaseAppBar(
        title: "Thông tin cá nhân",
      ),
      body: Form(
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
            _imageBox(width),
            IconButton(
              icon: Icon(Icons.camera_alt),
              iconSize: 28.0,
              color: Colors.grey,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                          children: <Widget>[
                            ListTile(
                                title: Text("Chụp ảnh bằng camera"),
                                onTap: () {
                                  _getImage(fromCamera: true);
                                }),
                            Divider(),
                            ListTile(
                                title: Text("Chọn ảnh từ thư viện"),
                                onTap: () {
                                  _getImage(fromCamera: false);
                                }),
                          ]);
                    });
              },
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
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                color: Colors.blue,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Navigator.of(context).pushReplacementNamed("/account/edit", arguments: _user);
                  }
                },
                child: Text(
                  "Lưu thay đổi",
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _getImage({bool fromCamera: false}) async {
    var image = await ImagePicker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    setState(() {
      _image = image;
    });
  }

  Widget _imageBox(double size) {
    ImageProvider imageBox;
    if (_image != null) {
      imageBox = FileImage(
        _image,
      );
    } else if (_user.image != null && _user.image.isNotEmpty) {
      imageBox = NetworkImage(
        _user.image,
      );
    }
    if (imageBox != null) {
      return Container(
        padding: EdgeInsets.only(top: 10.0, left: size / 2, right: size / 2),
        child: CircleAvatar(
          backgroundColor: Colors.green,
          radius: size / 2,
          child: CircleAvatar(radius: size / 2 - 2.0, backgroundImage: imageBox),
        ),
      );
    }

    return SizedBox(height: 0.0);
  }

  void _upload() {
    if (_image == null) return;
    String base64Image = base64Encode(_image.readAsBytesSync());
    String fileName = _image.path.split("/").last;

    http.post("", body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
  }
}
