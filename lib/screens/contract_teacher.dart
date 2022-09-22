import 'package:anylearn/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:validators/validators.dart' as validator;

import '../blocs/auth/auth_blocs.dart';
import '../dto/contract.dart';
import '../dto/user_dto.dart';
import '../widgets/gradient_button.dart';
import '../widgets/loading_widget.dart';
import 'contract_sign.dart';

class ContractTeacherScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContractTeacherScreen();
}

class _ContractTeacherScreen extends State<ContractTeacherScreen> {
  late AuthBloc _authBloc;
  ContractDTO? _contract;
  bool openedForm = false;
  bool _agreedToc = true;

  final _formKey = GlobalKey<FormState>();
  final dateMask = new MaskedTextController(mask: '0000-00-00');
  final dobMask = new MaskedTextController(mask: '0000-00-00');

  @override
  void didChangeDependencies() {
    _authBloc = BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
        Text('title').tr();

    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý hợp đồng"),
        centerTitle: false,
      ),
      body: BlocListener(
          bloc: _authBloc,
          listener: (context, state) {
            if (state is AuthContractSuccessState) {
              setState(() {
                openedForm = false;
                // _authBloc..add(AuthContractLoadEvent(token: _user.token, contractId: 0));
              });
              _authBloc..add(AuthContractLoadEvent(token: user.token, contractId: 0));
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text("Hợp đông mới đã được tạo. Vui lòng xem lại và thực hiện kí hợp đồng để xác nhận."),
                ));
            }
            if (state is AuthContractFailState) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.error)));
            }
            if (state is AuthContractLoadFailState) {
              toast(state.error);
            }
          },
          child: BlocBuilder(
            bloc: BlocProvider.of<AuthBloc>(context),
            builder: (context, state) {
              if (state is AuthSuccessState) {
                user = state.user;
                _authBloc..add(AuthContractLoadEvent(token: user.token, contractId: 0));
              }

              if (state is AuthContractLoadSuccessState) {
                _contract = state.contract;
                print(_contract);
              }

              return user.token == ""
                  ? LoadingWidget()
                  : Container(
                      padding: EdgeInsets.all(15),
                      child: ListView(children: [
                        ListTile(
                          leading: Icon(MdiIcons.fileCertificateOutline),
                          title: Text("Trạng thái hợp đồng của tài khoản"),
                          subtitle:
                              user.isSigned == 0 ? Text("CHƯA CÓ HỢP ĐỒNG HIỆU LỰC") : _signedStatus(user.isSigned),
                          trailing: user.isSigned == 99 ? Icon(Icons.search) : Text(""),
                          onTap: () {
                            if (user.isSigned == 99) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ContractSignScreen(user: user, contractId: -1)));
                            }
                          },
                        ),
                        _contract != null && (_contract!.status == 1 || _contract!.status == 10)
                            ? ListTile(
                                shape: Border(
                                  top: BorderSide(color: (Colors.grey[300])!),
                                ),
                                leading: Icon(Icons.edit_notifications_outlined),
                                title: Text("Đang có hợp đồng chờ xử lí"),
                                subtitle: _signedStatus(_contract!.status),
                                trailing: _contract!.status == 1 ? Text("KÝ") : Text("XEM"),
                                onTap: () async {
                                  bool result = await Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ContractSignScreen(user: user, contractId: _contract!.id)));
                                  if (result) {
                                    _authBloc..add(AuthCheckEvent());
                                  }
                                },
                              )
                            : Text(""),
                        ListTile(
                          shape: Border(
                            top: BorderSide(color: (Colors.grey[300])!),
                          ),
                          leading: Icon(MdiIcons.certificate),
                          trailing: Icon(Icons.chevron_right),
                          title: Text("Cập nhật chứng chỉ"),
                          onTap: () {
                            Navigator.of(context).pushNamed("/account/docs", arguments: user.token);
                          },
                        ),
                        GradientButton(
                          title: "TẠO HỢP ĐỒNG MỚI",
                          height: 40.0,
                          function: () {
                            setState(() {
                              openedForm = true;
                              if (_contract == null) {
                                _contract = new ContractDTO();
                              }
                              _contract!.commission = user.commissionRate.toString();
                              dateMask.text = _contract!.certDate;
                              dobMask.text = _contract!.dob;
                            });
                          },
                        ),
                        openedForm == false
                            ? Container()
                            : Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Divider(),
                                    TextFormField(
                                      initialValue: user.commissionRate.toString(),
                                      onSaved: (value) {
                                        setState(() {
                                          _contract!.commission = value!;
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.length < 3 || double.tryParse(value) == null) {
                                          return "Là một con số phập phân, ví dụ 0.2";
                                        }
                                        _formKey.currentState!.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Phần trăm doanh thu của đối tác (số thập phân)",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      initialValue: _contract!.certId,
                                      onSaved: (value) {
                                        setState(() {
                                          _contract!.certId = value!;
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.length < 9) {
                                          return "CMND không hợp lệ";
                                        }
                                        _formKey.currentState!.save();
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
                                          _contract!.certDate = value!;
                                        });
                                      },
                                      validator: (value) {
                                        if (DateTime.tryParse(value!) == null) {
                                          return "Ngày không hợp lệ, nhập năm-tháng-ngày(yyyy-mm-dd)";
                                        }
                                        _formKey.currentState!.save();
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
                                      initialValue: _contract!.certPlace,
                                      onSaved: (value) {
                                        setState(() {
                                          _contract!.certPlace = value!;
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.length < 3) {
                                          return "Nơi cấp CMND không hợp lệ";
                                        }
                                        _formKey.currentState!.save();
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
                                          _contract!.dob = value!;
                                        });
                                      },
                                      validator: (value) {
                                        if (DateTime.tryParse(value!) == null) {
                                          return "Ngày không hợp lệ, nhập năm-tháng-ngày(yyyy-mm-dd)";
                                        }
                                        _formKey.currentState!.save();
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
                                      initialValue: _contract!.dob,
                                      onSaved: (value) {
                                        setState(() {
                                          _contract!.dobPlace = value!;
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.length < 3) {
                                          return "Nơi sinh";
                                        }
                                        _formKey.currentState!.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Nơi sinh",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      initialValue: _contract!.address,
                                      onSaved: (value) {
                                        setState(() {
                                          _contract!.address = value!;
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.length < 3) {
                                          return "Địa chỉ không hợp lệ";
                                        }
                                        _formKey.currentState!.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Địa chỉ",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      initialValue: _contract!.email,
                                      onSaved: (value) {
                                        setState(() {
                                          _contract!.email = value!;
                                        });
                                      },
                                      validator: (value) {
                                        if (!validator.isEmail(value!)) {
                                          return "Email không hợp lệ";
                                        }
                                        _formKey.currentState!.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Email",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      initialValue: _contract!.bankName,
                                      onSaved: (value) {
                                        setState(() {
                                          _contract!.bankName = value!;
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.length < 3) {
                                          return "Vui lòng nhập";
                                        }
                                        _formKey.currentState!.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Ngân hàng",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      initialValue: _contract!.bankBranch,
                                      onSaved: (value) {
                                        setState(() {
                                          _contract!.bankBranch = value!;
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.length < 3) {
                                          return "Vui lòng nhập";
                                        }
                                        _formKey.currentState!.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Chi nhánh ngân hàng",
                                        // contentPadding: EdgeInsets.all(5.0),
                                        // labelStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    TextFormField(
                                      initialValue: _contract!.bankNo,
                                      onSaved: (value) {
                                        setState(() {
                                          _contract!.bankNo = value!;
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.length < 3) {
                                          return "Vui lòng nhập";
                                        }
                                        _formKey.currentState!.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "STK Ngân hàng",
                                      ),
                                    ),
                                    TextFormField(
                                      initialValue: _contract!.bankAccount,
                                      onSaved: (value) {
                                        setState(() {
                                          _contract!.bankAccount = value!;
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.length < 3) {
                                          return "Vui lòng nhập";
                                        }
                                        _formKey.currentState!.save();
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Ngân hàng - Người thụ hưởng",
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, top: 0),
                                      child: CheckboxListTile(
                                        dense: true,
                                        controlAffinity: ListTileControlAffinity.leading,
                                        value: _agreedToc,
                                        onChanged: (value) => setState(() {
                                          // if (!_agreedToc) {
                                          //   showDialog(
                                          //       context: context,
                                          //       child: AlertDialog(
                                          //         scrollable: true,
                                          //         title: Text("Điều khoản sử dụng"),
                                          //         content: Html(
                                          //           data: _toc,
                                          //           shrinkWrap: true,
                                          //         ),
                                          //         actions: <Widget>[
                                          //           FlatButton(
                                          //             onPressed: () => Navigator.pop(context),
                                          //             child: Text("Đã đọc và đồng ý".toUpperCase()),
                                          //           )
                                          //         ],
                                          //       ));
                                          // }
                                          _agreedToc = value!;
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
                                        padding: EdgeInsets.only(top: 15, bottom: 30),
                                        width: double.infinity,
                                        child: GradientButton(
                                          color: Colors.green,
                                          colorSub: Colors.greenAccent,
                                          height: 40,
                                          title: "LƯU HỢP ĐỒNG MỚI",
                                          function: () {
                                            if (!_agreedToc) {
                                              showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  contentPadding: EdgeInsets.all(5),
                                                  scrollable: true,
                                                  title: Text(
                                                    "Chưa đồng ý điều khoản sử dụng.",
                                                    style: TextStyle(fontSize: 14),
                                                  ),
                                                  content: Text(
                                                      "Bạn vui lòng tick chọn đồng ý với điều khoản sử dụng của chúng tôi. Cảm ơn."),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () => Navigator.pop(context),
                                                      child: Text("Tôi sẽ đọc".toUpperCase()),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }
                                            if (_formKey.currentState!.validate()) {
                                              _formKey.currentState!.save();
                                              _authBloc
                                                ..add(AuthContractSaveEvent(token: user.token, contract: _contract!));
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
        return Text("MỚI TẠO / CHỜ BẠN KÝ", style: TextStyle(color: Colors.blue));
      case 10:
        return Text("BẠN ĐÃ KÝ / CHỜ CÔNG TY", style: TextStyle(color: Colors.blue));
      case 99:
        return Text("CÔNG TY ĐÃ DUYỆT / HOÀN TẤT", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold));
      case 0:
        return Text("ĐÃ BỊ HỦY", style: TextStyle(color: Colors.blue));
      default:
        return Text("");
    }
  }
}
