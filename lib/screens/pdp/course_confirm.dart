import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../blocs/pdp/pdp_blocs.dart';
import '../../dto/pdp_dto.dart';
import '../../dto/user_dto.dart';
import '../../widgets/gradient_button.dart';

class CourseConfirm extends StatelessWidget {
  final PdpDTO pdpDTO;
  final UserDTO user;
  final PdpBloc pdpBloc;

  CourseConfirm({Key key, this.pdpDTO, this.user, this.pdpBloc}) : super(key: key);

  final NumberFormat _moneyFormat = NumberFormat("###,###,###", 'vi_VN');

  @override
  Widget build(Object context) {
    return user.id == pdpDTO.author.id
        ? AlertDialog(
            content: Text("Bạn không thể đăng ký khóa học của chính bạn."),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Đã hiểu"),
                color: Colors.blue,
              )
            ],
          )
        : SimpleDialog(
            title: Text(
              "Xác nhận đăng ký",
              style: TextStyle(fontSize: 14),
            ),
            titlePadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            contentPadding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            children: <Widget>[
              Text.rich(TextSpan(
                text: "Bạn đang muốn đăng ký khóa học\n",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
                children: [
                  TextSpan(
                      text: pdpDTO.item.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.blue,
                      )),
                  TextSpan(text: "\ncủa: ", style: TextStyle()),
                  TextSpan(
                      text: pdpDTO.author.name,
                      style: TextStyle(
                        // color: Colors.pink,
                        fontWeight: FontWeight.w400,
                      )),
                  TextSpan(
                      text: "\nHọc phí: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      )),
                  TextSpan(
                      text: _moneyFormat.format(pdpDTO.item.price),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      )),
                  TextSpan(
                      text: "\nThời gian: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      )),
                  TextSpan(
                      text: pdpDTO.item.timeStart + " " + pdpDTO.item.dateStart,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        // color: Colors.pink,
                      )),
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text.rich(TextSpan(text: "Số dư Ví tiền: ", children: [
                  TextSpan(
                      text: _moneyFormat.format(user.walletM),
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                ])),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text.rich(TextSpan(text: "Bạn sẽ nhận được ", children: [
                  TextSpan(
                    text: _moneyFormat.format(pdpDTO.commission),
                    style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " điểm thưởng vào Ví cho giao dịch này.")
                ])),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: user.walletM >= pdpDTO.item.price
                    ? GradientButton(
                        function: () {
                          pdpBloc..add(PdpRegisterEvent(token: user.token, itemId: pdpDTO.item.id));
                          Navigator.of(context).pop();
                        },
                        title: "XÁC NHẬN",
                      )
                    : GradientButton(
                        function: () {
                          // pdpBloc..add(PdpRegisterEvent(token: user.token, itemId: pdpDTO.item.id));
                          Navigator.of(context).pushNamed("/deposit");
                        },
                        title: "ĐẾN NẠP TIỀN",
                      ),
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Tôi chưa muốn đăng ký",
                    style: TextStyle(color: Colors.grey),
                  ))
            ],
          );
  }
}
