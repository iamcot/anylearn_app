import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BankForm extends StatelessWidget {
  final formKey;
  final bankName;
  final bankBranch;
  final bankNo;
  final bankAccount;

  const BankForm({key, this.formKey, this.bankName, this.bankBranch, this.bankNo, this.bankAccount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          TextFormField(
            controller: bankName,
            validator: (value) {
              if (value == "") {
                return "Bạn cần nhập tên ngân hàng".tr();
              }
              formKey.currentState.save();
              return null;
            },
            decoration: InputDecoration(
              labelText: "Ngân hàng".tr(),
              contentPadding: EdgeInsets.all(5),
            ),
          ),
          TextFormField(
            controller: bankBranch,
             validator: (value) {
              if (value == "") {
                return "Bạn cần nhập chi nhánh ngân hàng".tr();
              }
              formKey.currentState.save();
              return null;
            },
            decoration: InputDecoration(
              labelText: "Chi nhánh".tr(),
              contentPadding: EdgeInsets.all(5),
            ),
          ),
          TextFormField(
            controller: bankNo,
             validator: (value) {
              if (value == "") {
                return "Bạn cần nhập Số tài khoản".tr();
              }
              formKey.currentState.save();
              return null;
            },
            decoration: InputDecoration(
              labelText: "Số tài khoản".tr(),
              contentPadding: EdgeInsets.all(5),
            ),
          ),
          TextFormField(
            controller: bankAccount,
             validator: (value) {
              if (value == "") {
                return "Bạn cần nhập Họ tên chủ tài khoản".tr();
              }
              formKey.currentState.save();
              return null;
            },
            decoration: InputDecoration(
              labelText: "Chủ tài khoản".tr(),
              contentPadding: EdgeInsets.all(5),
            ),
          ),
        ],
      ),
    );
  }
}
