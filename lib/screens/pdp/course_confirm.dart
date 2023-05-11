import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../dto/user_dto.dart';
import '../../main.dart';
import '../webview.dart';

class CourseConfirm extends StatefulWidget {
  final pdpDTO;
  final pdpBloc;

  const CourseConfirm({key, this.pdpDTO, this.pdpBloc}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CourseConfirm();
}

class _CourseConfirm extends State<CourseConfirm> {
  
  bool hasVoucher = false;
  bool childRegister = false;
  String dropdownValue = "0";
  Map<String, String> options = {"0": "Chọn thành viên".tr()};
  final voucherController = TextEditingController();

  final NumberFormat _moneyFormat = NumberFormat("###,###,###", 'vi_VN');

  @override
  Widget build(BuildContext context) {

    return user.id == widget.pdpDTO.author.id
        ? AlertDialog(
            content: Text("Bạn không thể đăng ký khóa học của chính bạn.").tr(),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Đã hiểu").tr(),
              )
            ],
          )
        : SimpleDialog(
            title: Text(
              "Xác nhận đăng ký".tr(),
              style: TextStyle(fontSize: 14),
            ),
            titlePadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            contentPadding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            children: <Widget>[
              Text.rich(TextSpan(
                text: "Bạn đang muốn đăng ký khóa học\n".tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
                children: [
                  TextSpan(
                      text: widget.pdpDTO.item.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.blue,
                      )),
                  TextSpan(
                      text: "\n${widget.pdpDTO.author.role == 'school'.tr() ? 'Trường'.tr() : 'Giảng viên'.tr()}: ",
                      style: TextStyle()),
                  TextSpan(
                      text: widget.pdpDTO.author.name,
                      style: TextStyle(
                        // color: Colors.pink,
                        fontWeight: FontWeight.w400,
                      )),
                  TextSpan(
                      text: "\nHọc phí: ".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      )),
                  TextSpan(
                      text: _moneyFormat.format(widget.pdpDTO.item.price),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      )),
                  TextSpan(
                      text: "\nKhai giảng: ".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      )),
                  TextSpan(
                      text: widget.pdpDTO.item.timeStart +
                          " " +
                          DateFormat('dd/MM').format(DateTime.parse(widget.pdpDTO.item.dateStart)),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        // color: Colors.pink,
                      )),
                ],
              )).tr(),
              // Padding(
              //   padding: const EdgeInsets.only(top: 15),
              //   child: Text.rich(TextSpan(text: "Số dư tài khoản: ", children: [
              //     TextSpan(
              //         text: _moneyFormat.format(user.walletM),
              //         style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              //   ])),
              // ),
              widget.pdpDTO.disableAnypoint
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text.rich(TextSpan(text: "Bạn sẽ nhận được ".tr(), children: [
                        TextSpan(
                          text: _moneyFormat.format(widget.pdpDTO.commission),
                          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: " anyPoint cho giao dịch này.".tr())
                      ])),
                    ),
              !hasVoucher
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          hasVoucher = true;
                        });
                      },
                      child: Text(
                        "Tôi có mã khuyến mãi".tr(),
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ))
                  : Container(
                      padding: EdgeInsets.only(bottom: 5, top: 10),
                      child: Row(children: [
                        Expanded(
                          child: TextFormField(
                            controller: voucherController,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: (Colors.blue[200])!, width: 3),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              hintText: "Mã khuyến mãi khóa học".tr(),
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                hasVoucher = false;
                              });
                            })
                      ]),
                    ),
              childRegister
                  ? Row(children: [
                      Expanded(child: _buildChildrenSelector(context, user.children!)),
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () async {
                            // user.inRegisterClassId = widget.pdpDTO.item.id;
                            Navigator.of(context).pop();
                            await Navigator.of(context).pushNamed("/account/children", arguments: user);
                            BlocProvider.of<AuthBloc>(context)..add(AuthCheckEvent());
                          }),
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              childRegister = false;
                            });
                          })
                    ])
                  : TextButton(
                      onPressed: () {
                        setState(() {
                          childRegister = true;
                        });
                      },
                      child: Text(
                        "Tôi muốn đăng ký cho tài khoản con",
                        style: TextStyle(color: Colors.blue),
                      ).tr()),
              Container(
                // padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>((Colors.green[600])!),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ))),
                  onPressed: () {
                    _add2Cart(context, user.token, widget.pdpDTO.item.id, voucherController.text,
                        (dropdownValue != "0" && childRegister ? int.parse(dropdownValue) : 0));
                  },
                  child: Text("XÁC NHẬN").tr(),
                ),
              ),
            ],
          );
  }

  void _add2Cart(BuildContext context, String token, int itemId, String voucher, int childId) {
    String url = config.webUrl + "add2cart?class=$itemId&voucher=$voucher&child=$childId";
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WebviewScreen(
              url: url,
              token: token,
            )));
  }

  Widget _buildChildrenSelector(BuildContext context, List<UserDTO> children) {
    children.forEach((child) {
      options[child.id.toString()] = child.name;
    });
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.keyboard_arrow_down),
      iconSize: 24,
      elevation: 16,
      isExpanded: true,
      selectedItemBuilder: (BuildContext context) => _buildSelected(context),
      style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
      underline: Container(
        color: Colors.transparent,
      ),
      onChanged: (newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: _buildList(),
    );
  }

  List<Widget> _buildSelected(BuildContext context) {
    List<Widget> list = [];
    options.forEach((key, title) {
      list.add(Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.blue),
        ),
      ));
    });
    return list;
  }

  List<DropdownMenuItem<String>> _buildList() {
    List<DropdownMenuItem<String>> list = [];
    options.forEach((key, title) {
      list.add(
        DropdownMenuItem<String>(
          value: key,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: dropdownValue == key ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      );
    });
    return list;
  }
}
