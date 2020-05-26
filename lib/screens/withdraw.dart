import 'package:flutter/material.dart';

class WithdrawScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WithdrawScreen();
}

class _WithdrawScreen extends State<WithdrawScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rút tiền về ngân hàng"),
        centerTitle: false,
      ),
      body: Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Expanded(
                          child: Text.rich(
                        TextSpan(
                          text: "Số điểm: ".toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                          children: [
                            TextSpan(
                                text: "1024",
                                style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 16.0)),
                          ],
                        ),
                      )),
                      Text.rich(
                        TextSpan(
                          text: "Lịch sử điểm".toUpperCase(),
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ]),
                  ),
                ),
                Card(
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        // Text(
                        //   "Số điểm rút",
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // ),
                        TextFormField(
                          controller: _amountInput,
                          style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Nhập số điểm muốn rút",
                              hintStyle: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                              ),
                              icon: Text(
                                "ĐIỂM",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                        TextFormField(
                          readOnly: true,
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Số tiền quy đổi rút được",
                              hintStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              ),
                              icon: Text(
                                "VND",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Bạn chỉ được rút tối đa 80 điểm",
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Thông tin ngân hàng".toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent, Colors.blue]),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 40.0,
                  child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Rút tiền".toUpperCase(),
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      )),
                ),
                Divider(
                  thickness: 0,
                  height: 20.0,
                  color: Colors.transparent,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Lịch sử rút tiền gần đây".toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
