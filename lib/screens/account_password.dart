import '../widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:validators/validators.dart' as validator;
import 'package:http/http.dart' as http;

class AccountPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountPasswordScreen();
}

class _AccountPasswordScreen extends State<AccountPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String oldPassword;
  String newPassword;
  String confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Đổi mật khẩu",
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: Text(
                "Đổi mật khẩu của bạn",
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.grey[600]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 30.0),
              child: TextFormField(
                onSaved: (value) {
                  setState(() {
                    oldPassword = value;
                  });
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Mật khẩu cũ là bắt buộc";
                  }
                   _formKey.currentState.save();
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Mật khẩu cũ",
                  icon: Icon(MdiIcons.keyRemove),
                ),
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 30.0),
              child: TextFormField(
                onSaved: (value) {
                  setState(() {
                    newPassword = value;
                  });
                },
                validator: (String value) {
                  if (value.length < 8) {
                    return "Mật khẩu ít nhất 8 kí tự";
                  }
                   _formKey.currentState.save();
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Mật khẩu mới",
                  icon: Icon(MdiIcons.formTextboxPassword),
                ),
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 30.0),
              child: TextFormField(
                onSaved: (value) {
                  setState(() {
                    confirmPassword = value;
                  });
                },
                validator: (String value) {
                  if (value != newPassword) {
                    return "Xác nhận mât khẩu không đúng";
                  }
                   _formKey.currentState.save();
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Nhập lại mật khẩu mới",
                  icon: Icon(MdiIcons.formTextboxPassword),
                ),
                obscureText: true,
              ),
            ),
            Container(
              height: 36.0,
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                color: Colors.blue,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Navigator.of(context).pushReplacementNamed("/account/password");
                  }
                },
                child: Text(
                  "Đổi mật khẩu",
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
