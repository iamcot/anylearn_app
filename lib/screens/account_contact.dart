import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AccountContactScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountContactScreen();
}

class _AccountContactScreen extends State<AccountContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Liên hệ với chúng tôi"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.topCenter,
        child: Text.rich(
          TextSpan(
            text:
                "Xin lỗi! Tính năng này đang được hoàn thiện. Vui lòng phản hồi với chúng tôi qua các kênh trực tiếp.",
            style: TextStyle(fontSize: 16.0),
            children: <TextSpan>[
              TextSpan(
                  text: "TẠI ĐÂY",
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamed("/account/about");
                    }),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
