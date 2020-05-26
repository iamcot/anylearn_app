import 'package:flutter/material.dart';

class DepositScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DepositScreen();
}

class _DepositScreen extends State<DepositScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nạp tiền vào ví"),
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
                    child: Text.rich(
                      TextSpan(
                        text: "Số dư: ".toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                        children: [
                          TextSpan(
                              text: "230.000",
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16.0)),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        // Text(
                        //   "Số tiền nạp",
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // ),
                        TextFormField(
                          controller: _amountInput,
                          style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Nhập số tiền cần nạp",
                              hintStyle: TextStyle(
                                fontSize: 20.0,
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
                            "Bạn hãy nạp thêm 100.000 để nhận tài khoản VIP tới ngày 21/06",
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Phương thức thanh toán".toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                ),
                RadioListTile(
                  dense: true,
                  title: Text(
                    "Chuyển khoản ngân hàng",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Thông tin chuyển khoản sẽ được gửi tới quý khách hàng ngay khi xác nhận nạp"),
                  value: "atm",
                  groupValue: "payment",
                  onChanged: (value) {},
                ),
                RadioListTile(
                  dense: true,
                  title:
                      Text.rich(TextSpan(text: "Đổi điểm.", style: TextStyle(fontWeight: FontWeight.bold), children: [
                    TextSpan(text: " Bạn đang có: ", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal)),
                    TextSpan(text: "100", style: TextStyle(
                      color: Colors.orange
                    )),
                    TextSpan(text: " điểm", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal)),
                  ])),
                  subtitle: Text("Bạn sẽ được chuyển sang trang đổi điểm."),
                  value: "atm",
                  groupValue: "payment",
                  onChanged: (value) {},
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
                        "Nạp tiền".toUpperCase(),
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
                    "Lịch sử nạp tiền gần đây".toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
