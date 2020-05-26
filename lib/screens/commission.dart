import 'package:flutter/material.dart';

class CommissionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CommissionScreen();
}

class _CommissionScreen extends State<CommissionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đổi điểm sang ví tiền"),
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
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent, Colors.blue]),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 40.0,
                  child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Đổi điểm".toUpperCase(),
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
                    "Lịch sử đổi điểm gần đây".toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
