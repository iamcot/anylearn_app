import 'package:anylearn/blocs/auth/auth_bloc.dart';
import 'package:anylearn/blocs/auth/auth_blocs.dart';
import 'package:anylearn/blocs/auth/auth_event.dart';
import 'package:anylearn/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

class AccountDeleteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountDeleteScreen();
}

class _AccountDeleteScreen extends State<AccountDeleteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: BlocProvider.of<AuthBloc>(context),
      listener: (context, state) async {
        if (state is AuthDeleteFailState) {
          toast(state.error);
        }
        if (state is AuthDeleteSuccessState) {
          toast("TÀI KHOẢN CỦA BẠN ĐÃ ĐƯỢC XÓA, ĐĂNG XUẤT...".tr());
          await Future.delayed(Duration(seconds: 5));
          BlocProvider.of<AuthBloc>(context)..add(AuthLoggedOutEvent(token: user.token));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("Xóa tài khoản").tr(),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(children: <Widget>[
            Container(
              child: Text(
                "Bạn đang gửi yêu cầu để XÓA hoàn toàn tài khoản của bạn, điều đó đồng nghĩa:\n".tr() +
                    "- Bạn không thể khôi phục hay tiếp tục sử dụng tài khoản này\n".tr() +
                    "- Mọi khóa học bạn tạo sẽ bị XÓA\n".tr() +
                    "- Mọi ưa thích bạn tạo sẽ bị XÓA\n".tr() +
                    "- Mọi dữ liệu khác của bạn sẽ không thể tìm kiếm và sử dụng lại.\n".tr(),
                style: TextStyle(fontSize: 16.0, height: 2.0),
              ),
            ),
            Container(
              child: Text(
                "SẼ KHÔNG CÓ BẤT KỲ BƯỚC XÁC THỰC NÀO, HÃY CHẮN CHẮN BÁN MUỐN XÓA TÀI KHOẢN!".tr(),
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text("XÓA TÀI KHOẢN").tr(),
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () async {
                  final rs = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: new Text("Xác nhận XÓA!"),
                            content: new Text("Bạn đã chắc chắn XÓA TÀI KHOẢN").tr(),
                            actions: <Widget>[
                              new TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: new Text("Không muốn").tr(),
                              ),
                              new ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                                onPressed: () => Navigator.of(context).pop(true),
                                child: new Text(
                                  "Chắn chắn xóa".tr(),
                                ),
                              ),
                            ],
                          ));
                  if (rs) {
                    BlocProvider.of<AuthBloc>(context)..add(AuthDeleteEvent(token: user.token));
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
