import 'dart:io';

import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../dto/account_calendar_dto.dart';
import '../dto/friends_dto.dart';
import '../dto/user_dto.dart';
import '../dto/users_dto.dart';
import 'base_service.dart';

class UserService extends BaseService {
  final http.Client httpClient;
  final AppConfig config;

  UserService({this.config, this.httpClient});

  Future<UserDTO> login(String phone, String password) async {
    final url = buildUrl(
        appConfig: config,
        endPoint: "/login",
        query: buildQuery(
          {'phone': phone, 'password': password},
        ));
    print(url);
    final json = await get(httpClient, url);
    return UserDTO.fromJson(json);
  }

  Future<UserDTO> getInfo(String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/user", token: token);
    print(url);
    final json = await get(httpClient, url);
    return UserDTO.fromJson(json);
  }

  Future<UsersDTO> getList(String role, int page, int pageSize) async {
    final url =
        buildUrl(appConfig: config, endPoint: "/users/$role", query: buildQuery({"page": page, "pageSize": pageSize}));
    print(url);
    final json = await get(httpClient, url);
    return UsersDTO.fromJson(json);
  }

  Future<bool> updateInfo(UserDTO user) async {
    final url = buildUrl(appConfig: config, endPoint: "/user/edit", token: user.token);
    final json = await post(httpClient, url, {
      "name": user.name,
      "refcode": user.refcode,
      "title": user.title,
      "introduce": user.introduce,
      "phone": user.phone,
      "email": user.email,
      "address": user.address,
      "country": user.country,
    });
    return json["result"];
  }

  Future<bool> updatePassword(String oldPassword, String newPassword) async {
    await Future.delayed(Duration(seconds: 1));
    //TODO Implement
    return true;
  }

  Future<UserDTO> register(String phone, String name, String password, String refcode, String role) async {
    final url = buildUrl(appConfig: config, endPoint: "/register");
    print(url);
    final json = await post(httpClient, url, {
      "phone": phone,
      "name": name,
      "password": password,
      "ref": refcode,
      "role": role,
    });
    return UserDTO.fromJson(json);
  }

  Future<String> uploadUserImage(String type, String token, File file) async {
    final url = buildUrl(appConfig: config, endPoint: "/user/upload-image/$type", token: token);
    print(url);
    final rs = await postImage(url, file);
    return rs;
  }

  Future<FriendsDTO> friends(String token, int userId) async {
    final url = buildUrl(appConfig: config, endPoint: "/friends/$userId", token: token);
    print(url);
    final json = await get(httpClient, url);
    return FriendsDTO.fromJson(json);
  }

  Future<AccountCalendarDTO> myCalendar(String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/user/mycalendar", token: token);
    print(url);
    final json = await get(httpClient, url);
    return AccountCalendarDTO.fromJson(json);
  }

  Future<int> joinCourse(String token, int itemId) async {
    final url = buildUrl(appConfig: config, endPoint: "/user/join/$itemId", token: token);
    print(url);
    final json = await get(httpClient, url);
    return json['result'];
  }

  Future<List<UserDTO>> registeredUsers(String token, int itemId) async {
    final url = buildUrl(appConfig: config, endPoint: "/user/course-registered-users/$itemId", token: token);
    print(url);
    final json = await get(httpClient, url);
    return List<UserDTO>.from(json?.map((e) => e == null ? null : UserDTO.fromJson(e))).toList();
  }
}
