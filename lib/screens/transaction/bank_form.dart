import 'package:flutter/material.dart';

class BankForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController bankName;
  final TextEditingController bankBranch;
  final TextEditingController bankNo;
  final TextEditingController bankAccount;

  const BankForm({Key key, this.formKey, this.bankName, this.bankBranch, this.bankNo, this.bankAccount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            controller: bankName,
            validator: (value) {
              if (value.isEmpty) {
                return "Bạn cần nhập tên ngân hàng";
              }
              formKey.currentState.save();
              return null;
            },
            decoration: InputDecoration(
              labelText: "Ngân hàng",
              contentPadding: EdgeInsets.all(5),
            ),
          ),
          TextFormField(
            controller: bankBranch,
             validator: (value) {
              if (value.isEmpty) {
                return "Bạn cần nhập chi nhánh ngân hàng";
              }
              formKey.currentState.save();
              return null;
            },
            decoration: InputDecoration(
              labelText: "Chi nhánh",
              contentPadding: EdgeInsets.all(5),
            ),
          ),
          TextFormField(
            controller: bankNo,
             validator: (value) {
              if (value.isEmpty) {
                return "Bạn cần nhập Số tài khoản";
              }
              formKey.currentState.save();
              return null;
            },
            decoration: InputDecoration(
              labelText: "Số tài khoản",
              contentPadding: EdgeInsets.all(5),
            ),
          ),
          TextFormField(
            controller: bankAccount,
             validator: (value) {
              if (value.isEmpty) {
                return "Bạn cần nhập Họ tên chủ tài khoản";
              }
              formKey.currentState.save();
              return null;
            },
            decoration: InputDecoration(
              labelText: "Chủ tài khoản",
              contentPadding: EdgeInsets.all(5),
            ),
          ),
        ],
      ),
    );
  }
}
