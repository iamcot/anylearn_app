import 'package:flutter/material.dart';

import '../dto/user_dto.dart';

class UserRepository {
  UserDTO user;
  Future<String> authenticated({@required String phone, @required String password}) async {
    await Future.delayed(Duration(seconds: 1));
    //TODO call API
    user = new UserDTO(
      name: "Iam CoT",
      role: "member",
    );
    return 'mocktoken';
  }

  Future<void> deleteToken() async {
    await Future.delayed(Duration(seconds: 1));
    //TODO delete from keystore/keychain
    user = null;
    return;
  }

  Future<void> storeToken(String token) async {
    ///TODO save to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    //TODO read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
