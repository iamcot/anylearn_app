import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../dto/const.dart';
import '../dto/user_dto.dart';
import '../dto/users_dto.dart';
import '../services/user_services.dart';

class UserRepository {
  final userService = new UserService();
  final storage = new FlutterSecureStorage();

  Future<UserDTO> getUser(String token) async {
    return await userService.getInfo(token);
  }

  Future<UserDTO> authenticated({@required String phone, @required String password}) async {
    return await userService.login(phone, password);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: MyConst.AUTH_TOKEN);
    return;
  }

  Future<void> storeToken(String token) async {
    await storage.write(key: MyConst.AUTH_TOKEN, value: token);
    return;
  }

  Future<String> getToken() async {
    return await storage.read(key: MyConst.AUTH_TOKEN);
  }

  Future<UsersDTO> getUserList(String role) async {
    return UsersDTO(
      banner:
          "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
      list: [
        new UserDTO(
          name: "Giáo viên A",
          title: "MC, Giảng viên",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/items",
          introduce: "Có giới thiệu ngắn",
          rating: 5.0,
        ),
        new UserDTO(
          name: "Tiến sỹ B",
          title: "Giáo viên B có gt siêu dài cần cắt bớt đi cho đẹp",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/items",
          rating: 0.0,
        ),
        new UserDTO(
          name: "Giáo viên C",
          title: "MC, Giảng viên",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          route: "/items",
          introduce: "Có giới thiệu ngắn",
          rating: 0.0,
        ),
      ],
    );
  }
}
