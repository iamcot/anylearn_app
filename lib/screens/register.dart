import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:validators/validators.dart' as validator;

import '../blocs/auth/auth_blocs.dart';
import '../blocs/register/register_blocs.dart';
import '../customs/custom_radio.dart';
import '../customs/register_curved_paint.dart';
import '../dto/const.dart';
import '../dto/user_dto.dart';
import '../models/user_repo.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _toc = "toc";
  UserDTO _user = new UserDTO(
    role: MyConst.ROLE_MEMBER,
  );
  String confirmPassword;
  bool _agreedToc = false;

  final FocusNode _focusRef = FocusNode();
  final FocusNode _focusName = FocusNode();
  final FocusNode _focusPhone = FocusNode();
  final FocusNode _focusPass = FocusNode();
  final FocusNode _focusRePass = FocusNode();

  RegisterBloc _loginBloc;
  AuthBloc _authBloc;
  @override
  void didChangeDependencies() {
    final userRepository = RepositoryProvider.of<UserRepository>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    _loginBloc = RegisterBloc(userRepository: userRepository);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;

    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Navigator.of(context).popUntil(ModalRoute.withName("/"));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/images/logo_text.png",
            height: 40.0,
          ),
          elevation: 0.0,
        ),
        body: BlocListener<RegisterBloc, RegisterState>(
          bloc: _loginBloc,
          listener: (context, state) {
            if (state is RegisterFailState) {
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: Text(state.error),
              ));
            }
            // if (state is RegisterSuccessState) {
              // Navigator.of(context).pushNamed("/login", arguments: "Đăng ký thành công, vui lòng đăng nhập lại.");
            // }
          },
          child: Container(
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  CustomPaint(
                    child: Container(
                      height: 100.0,
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(right: width / 4, bottom: 20.0),
                      child: Text(
                        "Đăng ký",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    painter: CustomCurvedPaint(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                    child: TextFormField(
                      initialValue: _user.refcode,
                      onSaved: (value) {
                        setState(() {
                          _user.refcode = value;
                        });
                      },
                      focusNode: _focusRef,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _focusRef, _focusName);
                      },
                      decoration: InputDecoration(
                        labelText: "Mã giới thiệu",
                        contentPadding: EdgeInsets.all(5.0),
                        labelStyle: TextStyle(fontSize: 14.0),
                        prefixIcon: Icon(MdiIcons.qrcode),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
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
                      focusNode: _focusName,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _focusName, _focusPhone);
                      },
                      decoration: InputDecoration(
                        labelText: "Họ & Tên",
                        prefixIcon: Icon(MdiIcons.account),
                        labelStyle: TextStyle(fontSize: 14.0),
                        contentPadding: EdgeInsets.all(5.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: TextFormField(
                      initialValue: _user.phone,
                      onSaved: (value) {
                        setState(() {
                          _user.phone = value;
                        });
                      },
                      validator: (String value) {
                        if (!validator.isNumeric(value)) {
                          return "Số điện thoại không hợp lệ";
                        }
                        _formKey.currentState.save();
                        return null;
                      },
                      focusNode: _focusPhone,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _focusPhone, _focusPass);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5.0),
                        labelText: "Số điện thoại",
                        labelStyle: TextStyle(fontSize: 14.0),
                        prefixIcon: Icon(MdiIcons.phone),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: TextFormField(
                      onSaved: (value) {
                        setState(() {
                          _user.password = value;
                        });
                      },
                      validator: (String value) {
                        if (value.length < 8) {
                          return "Mật khẩu ít nhất 8 kí tự";
                        }
                        _formKey.currentState.save();
                        return null;
                      },
                      focusNode: _focusPass,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _focusPass, _focusRePass);
                      },
                      decoration: InputDecoration(
                        labelText: "Mật khẩu",
                        prefixIcon: Icon(MdiIcons.lock),
                        labelStyle: TextStyle(fontSize: 14.0),
                        contentPadding: EdgeInsets.all(5.0),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: TextFormField(
                      onSaved: (value) {
                        setState(() {
                          confirmPassword = value;
                        });
                      },
                      focusNode: _focusRePass,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (term) {
                        _focusRePass.unfocus();
                      },
                      validator: (String value) {
                        if (value != _user.password) {
                          return "Xác nhận mât khẩu không đúng";
                        }
                        _formKey.currentState.save();
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Nhập lại mật khẩu",
                        prefixIcon: Icon(MdiIcons.lockCheck),
                        labelStyle: TextStyle(fontSize: 14.0),
                        contentPadding: EdgeInsets.all(5.0),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 15.0),
                    child: Text("Tôi là: "),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Row(
                      children: <Widget>[
                        CustomRadio(
                          groupValue: _user.role,
                          value: MyConst.ROLE_MEMBER,
                          label: "Học viên",
                          func: () => _selectRole(MyConst.ROLE_MEMBER),
                        ),
                        CustomRadio(
                            groupValue: _user.role,
                            value: MyConst.ROLE_TEACHER,
                            label: "Giảng viên",
                            func: () => _selectRole(MyConst.ROLE_TEACHER)),
                        CustomRadio(
                          groupValue: _user.role,
                          value: MyConst.ROLE_SCHOOL,
                          label: "Trung tâm",
                          func: () => _selectRole(MyConst.ROLE_SCHOOL),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 0),
                    child: CheckboxListTile(
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _agreedToc,
                      onChanged: (value) => setState(() {
                        if (!_agreedToc) {
                          showDialog(
                              context: context,
                              child: AlertDialog(
                                scrollable: true,
                                title: Text("Điều khoản sử dụng"),
                                content: Html(
                                  data: _toc,
                                  shrinkWrap: true,
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Đã đọc và đồng ý".toUpperCase()),
                                  )
                                ],
                              ));
                        }
                        _agreedToc = value;
                      }),
                      title: Text.rich(TextSpan(text: "Tôi đồng ý với ", children: [
                        TextSpan(
                          text: "Điều khoản sử dụng",
                          style: TextStyle(color: Colors.red),
                        ),
                      ])),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent, Colors.blue]),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 40.0,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 15.0),
                    child: FlatButton(
                      onPressed: () {
                        _submitForm(context);
                      },
                      child: Text(
                        "Đăng ký",
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 30.0),
                    child: Text.rich(
                      TextSpan(text: "Bạn đã có tài khoản?", children: [
                        TextSpan(
                            text: " Đăng nhập",
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).popAndPushNamed("/login");
                              })
                      ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectRole(String value) {
    setState(() {
      _user.role = value;
    });
  }

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _submitForm(BuildContext context) {
    if (!_agreedToc) {
      showDialog(
        context: context,
        child: AlertDialog(
          scrollable: true,
          title: Text(
            "Chưa đồng ý điều khoản sử dụng.",
            style: TextStyle(fontSize: 14),
          ),
          content: Text("Bạn vui lòng đọc và tick chọn đồng ý với điều khoản sử dụng của chúng tôi. Cảm ơn."),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Tôi sẽ đọc".toUpperCase()),
            )
          ],
        ),
      );
    }
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _loginBloc.add(RegisterButtonPressedEvent(userInput: _user));
    }
  }
}
