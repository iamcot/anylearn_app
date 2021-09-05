import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:validators/validators.dart' as validator;

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_blocs.dart';
import '../dto/const.dart';
import '../dto/contract.dart';
import '../dto/user_dto.dart';
import '../widgets/gradient_button.dart';
import '../widgets/loading_widget.dart';

class ContractTeacherScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContractTeacherScreen();
}

class _ContractTeacherScreen extends State<ContractTeacherScreen> {
  UserDTO _user;
  AuthBloc _authBloc;
  bool openedForm = false;
  ContractDTO _contract = ContractDTO();
  final _formKey = GlobalKey<FormState>();
  final dateMask = new MaskedTextController(mask: '0000-00-00');
  final dobMask = new MaskedTextController(mask: '0000-00-00');
  bool _agreedToc = false;

  @override
  void didChangeDependencies() {
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý hợp đồng"),
        centerTitle: false,
      ),
      body: BlocListener(
          bloc: BlocProvider.of<AuthBloc>(context),
          listener: (context, state) {
            if (state is AuthContractSuccessState) {
              setState(() {
                _user.isSigned = MyConst.CONTRACT_SIGNED;
                openedForm = false;
              });
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  duration: Duration(seconds: 8),
                  content: Text(
                      "Hợp đông mới đã được tạo, Vui lòng thực hiện bước tiếp theo để ký hợp đồng. Mức hoa hồng mới nếu có sẽ được cập nhật khi chúng tôi duyệt hợp đồng."),
                ));
            }
            if (state is AuthContractFailState) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder(
            bloc: BlocProvider.of<AuthBloc>(context),
            builder: (context, state) {
              if (state is AuthSuccessState) {
                _user = state.user;
                _contract.commission = _user.commissionRate.toString();
              }
              return _user == null
                  ? LoadingWidget()
                  : Container(
                      padding: EdgeInsets.all(15),
                      child: ListView(children: [
                        _user.isSigned == 0
                            ? Container(
                                child: Text("BẠN CHƯA KÝ HỢP ĐỒNG VỚI CHÚNG TÔI."),
                              )
                            : Container(
                                child: ListTile(
                                  leading: Icon(MdiIcons.fileCertificateOutline),
                                  title: Text(
                                    "Bạn đã có một hợp đồng",
                                    style: TextStyle(),
                                  ),
                                  subtitle: _signedStatus(_user.isSigned),
                                  trailing: Text(
                                    _user.isSigned == 1 ? "KÝ HĐ" : "XEM HĐ",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed("/contract/sign");
                                  },
                                ),
                              ),
                        Divider(),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: FlatButton.icon(
                              onPressed: () {
                                Navigator.of(context).pushNamed("/account/docs", arguments: _user.token);
                              },
                              icon: Icon(MdiIcons.certificate),
                              label: Text("Cập nhật chứng chỉ")),
                        ),
                        Divider(),
                        GradientButton(
                          title: "TẠO HỢP ĐỒNG MỚI",
                          height: 40.0,
                          function: () {
                            setState(() {
                              openedForm = true;
                            });
                          },
                        ),
                        openedForm == false
                            ? SizedBox(
                                height: 0,
                              )
                            : Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Divider(),
                                    TextFormField(
                                      initialValue: _user.commissionRate.toString(),
                                      onSaved: (value) {
                                        setState(() {
                                          _contract.commission = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.length < 3 || double.tryParse(value) == null) {
                                          return "Là một con số phập phân, ví dụ 0.2";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Phần trăm doanh thu của đối tác (số thập phân)",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      onSaved: (value) {
                                        setState(() {
                                          _contract.certId = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.length < 9) {
                                          return "CMND không hợp lệ";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "CMND",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      onSaved: (value) {
                                        setState(() {
                                          _contract.certDate = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (DateTime.tryParse(value) == null) {
                                          return "Ngày không hợp lệ, nhập năm-tháng-ngày(yyyy-mm-dd)";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      controller: dateMask,
                                      decoration: InputDecoration(
                                        hintText: "yyyy-mm-dd",
                                        labelText: "Ngày cấp CMND",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      onSaved: (value) {
                                        setState(() {
                                          _contract.certPlace = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.length < 3) {
                                          return "Nơi cấp CMND không hợp lệ";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Nơi cấp CMND",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      onSaved: (value) {
                                        setState(() {
                                          _contract.dob = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (DateTime.tryParse(value) == null) {
                                          return "Ngày không hợp lệ, nhập năm-tháng-ngày(yyyy-mm-dd)";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      controller: dobMask,
                                      decoration: InputDecoration(
                                        hintText: "yyyy-mm-dd",
                                        labelText: "Ngày sinh",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      onSaved: (value) {
                                        setState(() {
                                          _contract.dobPlace = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.length < 3) {
                                          return "Nơi sinh";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Nơi sinh",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      onSaved: (value) {
                                        setState(() {
                                          _contract.address = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.length < 3) {
                                          return "Địa chỉ không hợp lệ";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Địa chỉ",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      onSaved: (value) {
                                        setState(() {
                                          _contract.email = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (!validator.isEmail(value)) {
                                          return "Email không hợp lệ";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Email",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      onSaved: (value) {
                                        setState(() {
                                          _contract.bankName = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.length < 3) {
                                          return "Vui lòng nhập";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Ngân hàng",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      onSaved: (value) {
                                        setState(() {
                                          _contract.bankBranch = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.length < 3) {
                                          return "Vui lòng nhập";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Chi nhánh ngân hàng",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      onSaved: (value) {
                                        setState(() {
                                          _contract.bankNo = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.length < 3) {
                                          return "Vui lòng nhập";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "STK Ngân hàng",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      onSaved: (value) {
                                        setState(() {
                                          _contract.bankAccount = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.length < 3) {
                                          return "Vui lòng nhập";
                                        }
                                        _formKey.currentState.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Ngân hàng - Người thụ hưởng",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, top: 0),
                                      child: CheckboxListTile(
                                        dense: true,
                                        controlAffinity: ListTileControlAffinity.leading,
                                        value: _agreedToc,
                                        onChanged: (value) => setState(() {
                                          _agreedToc = value;
                                        }),
                                        title: Text.rich(
                                            TextSpan(text: "Tôi xác nhận ký hợp đồng và đồng ý với ", children: [
                                          TextSpan(
                                            text: "Điều khoản sử dụng",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ])),
                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(top: 15, bottom: 30),
                                        width: double.infinity,
                                        child: GradientButton(
                                          color: Colors.green,
                                          colorSub: Colors.greenAccent,
                                          height: 40,
                                          title: "LƯU HỢP ĐỒNG MỚI",
                                          function: () {
                                            if (_formKey.currentState.validate()) {
                                              _formKey.currentState.save();
                                              _authBloc
                                                ..add(AuthContractSaveEvent(token: _user.token, contract: _contract));
                                            }
                                          },
                                        )),
                                  ],
                                ),
                              ),
                      ]),
                    );
            },
          )),
    );
  }

  Widget _signedStatus(int status) {
    switch (status) {
      case 1:
        return Text("MỚI TẠO", style: TextStyle(color: Colors.blue));
      case 10:
        return Text("BẠN ĐÃ KÝ", style: TextStyle(color: Colors.blue));
      case 99:
        return Text("CÔNG TY ĐÃ DUYỆT", style: TextStyle(color: Colors.blue));
      case 0:
        return Text("ĐÃ BỊ HỦY", style: TextStyle(color: Colors.blue));
      default:
        return Text("");
    }
  }
}
