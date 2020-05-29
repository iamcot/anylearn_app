import 'dart:convert';

import 'package:anylearn/customs/rest_exception.dart';
import 'package:anylearn/services/base_service.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../dto/user_dto.dart';
import '../dto/users_dto.dart';

class UserService extends BaseService {
  final http.Client httpClient;
  final AppConfig config;

  UserService({this.config, this.httpClient});

  Future<UserDTO> login(String phone, String password) async {
    String url = config.apiUrl + config.loginEP + "?phone=$phone&password=$password";
    print(url);
    final json = await get(url);
    return UserDTO.fromJson(json);
  }

  Future<UserDTO> getInfo(String token) async {
    String url = config.apiUrl + config.userInfoEP + "?${config.tokenParam}=$token";
    print(url);
    final json = await get(url);
    return UserDTO.fromJson(json);
  }

  Future<UsersDTO> getList(String role, int page, int pageSize) async {
    await Future.delayed(Duration(microseconds: 500));
    //TODO MOCK
    return UsersDTO(
      banner:
          "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
      list: [
        new UserDTO(
          id: 1,
          name: "Giáo viên A",
          title: "MC, Giảng viên",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          introduce: "Có giới thiệu ngắn",
          rating: 5.0,
        ),
        new UserDTO(
          id: 2,
          name: "Tiến sỹ B",
          title: "Giáo viên B có gt siêu dài cần cắt bớt đi cho đẹp",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          rating: 0.0,
        ),
        new UserDTO(
          id: 3,
          name: "Giáo viên C",
          title: "MC, Giảng viên",
          image:
              "https://scholarship-positions.com/wp-content/uploads/2020/01/Free-Online-Course-on-Learning-to-Teach-Online.jpg",
          introduce: "Có giới thiệu ngắn",
          rating: 0.0,
        ),
      ],
    );
  }

  Future<bool> updateInfo(UserDTO user) async {
    await Future.delayed(Duration(microseconds: 500));
    //TODO Implement
    return true;
  }

  Future<bool> updatePassword(String oldPassword, String newPassword) async {
    await Future.delayed(Duration(microseconds: 500));
    //TODO Implement
    return true;
  }
}
