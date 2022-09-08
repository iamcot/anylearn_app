import 'package:anylearn/dto/bank_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BankInfo extends StatelessWidget {
  final BankDTO bankDTO;
  final String phone;

  const BankInfo({required this.bankDTO, required this.phone});
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Vui lòng chuyển khoản theo thông tin sau:", style: TextStyle(fontSize: 12.0)),
      children: [
        ListTile(
          title: Text("Ngân hàng"),
          subtitle: Text(bankDTO.bankName),
        ),
        ListTile(
          title: Text("Chi nhánh"),
          subtitle: Text(bankDTO.bankBranch),
        ),
        ListTile(
          title: Text("Số tài khoản"),
          subtitle: Text(bankDTO.bankNo),
          trailing: Icon(Icons.content_copy),
          onTap: () {
            Clipboard.setData(new ClipboardData(text: bankDTO.bankNo));
          },
        ),
        ListTile(
          title: Text("Người  thụ hưởng"),
          subtitle: Text(bankDTO.accountName),
        ),
        ListTile(
          title: Text("Nội dung chuyển khoản"),
          subtitle: Text(bankDTO.content + (phone != null ? " - $phone" : "")),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
