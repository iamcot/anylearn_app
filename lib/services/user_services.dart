import 'dart:convert';
import 'dart:io';

import 'package:anylearn/dto/notification_dto.dart';
import 'package:anylearn/main.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../dto/account_calendar_dto.dart';
import '../dto/friends_dto.dart';
import '../dto/user_doc_dto.dart';
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
          {'phone': phone, 'password': password, 'notif_token': notifToken},
        ));
    final json = await get(httpClient, url);
    return UserDTO.fromJson(json);
  }

  Future<void> logout(String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/logout", token: token);
    print(url);
    await get(httpClient, url);
    return;
  }

  Future<UserDTO> getInfo(String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/user", token: token);
    final json = await get(httpClient, url);
    return UserDTO.fromJson(json);
  }

  Future<UserDTO> getInfoLess(String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/user-less", token: token);
    final json = await get(httpClient, url);
    return UserDTO.fromJson(json);
  }

  Future<UsersDTO> getList(String role, int page, int pageSize) async {
    final url =
        buildUrl(appConfig: config, endPoint: "/users/$role", query: buildQuery({"page": page, "pageSize": pageSize}));
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
      "full_content": user.fullContent ?? "",
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
    final rs = await postImage(url, file);
    return rs;
  }

  Future<FriendsDTO> friends(String token, int userId) async {
    final url = buildUrl(appConfig: config, endPoint: "/friends/$userId", token: token);
    final json = await get(httpClient, url);
    return FriendsDTO.fromJson(json);
  }

  Future<AccountCalendarDTO> myCalendar(String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/user/mycalendar", token: token);
    final json = await get(httpClient, url);
    return AccountCalendarDTO.fromJson(json);
  }

  Future<int> joinCourse(String token, int itemId) async {
    final url = buildUrl(appConfig: config, endPoint: "/user/join/$itemId", token: token);
    final json = await get(httpClient, url);
    return json['result'];
  }

  Future<List<UserDTO>> registeredUsers(String token, int itemId) async {
    final url = buildUrl(appConfig: config, endPoint: "/user/course-registered-users/$itemId", token: token);
    final json = await get(httpClient, url);
    return List<UserDTO>.from(json?.map((e) => e == null ? null : UserDTO.fromJson(e))).toList();
  }

  Future<UserDTO> getProfile(int userId) async {
    final url = buildUrl(appConfig: config, endPoint: "/user/profile/$userId");
    final json = await get(httpClient, url);
    return UserDTO.fromJson(json);
  }

  Future<List<UserDocDTO>> getDocs(String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/user/get-docs", token: token);
    final json = await get(httpClient, url);
    return json == null
        ? null
        : List<UserDocDTO>.from(json?.map((e) => e == null ? null : UserDocDTO.fromJson(e))).toList();
  }

  Future<List<UserDocDTO>> addDoc(String token, File file) async {
    final url = buildUrl(appConfig: config, endPoint: "/user/add-doc", token: token);
    final jsonStr = await postImage(url, file);
    final rs = json.decode(jsonStr);
    return rs == null
        ? null
        : List<UserDocDTO>.from(rs?.map((e) => e == null ? null : UserDocDTO.fromJson(e))).toList();
  }

  Future<List<UserDocDTO>> removeDoc(String token, int fileId) async {
    final url = buildUrl(appConfig: config, endPoint: "/user/remove-doc/$fileId", token: token);
    final json = await get(httpClient, url);
    return json == null
        ? null
        : List<UserDocDTO>.from(json?.map((e) => e == null ? null : UserDocDTO.fromJson(e))).toList();
  }

  Future<NotificationPagingDTO> notification(String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/user/notification", token: token);
    final json = await get(httpClient, url);
    return json == null ? null : NotificationPagingDTO.fromJson(json);
  }

  Future<void> notifRead(String token, int id) async {
    final url = buildUrl(appConfig: config, endPoint: "/user/notification/" + id.toString(), token: token);
    // print(url);
    await get(httpClient, url);
    return;
  }

  Future<List<UserDTO>> allFriends(String token) async {
    final url = buildUrl(appConfig: config, endPoint: "/user/all-friends", token: token);
    final json = await get(httpClient, url);
    return List<UserDTO>.from(json?.map((e) => e == null ? null : UserDTO.fromJson(e))).toList();
  }

  Future<bool> shareFriends(String token, int id, List<int> friends, bool isALL) async {
    final url = buildUrl(appConfig: config, endPoint: "/item/$id/share", token: token);
    print(url);
    final json = await post(httpClient, url, {
      "friends": isALL ? "ALL" : jsonEncode(friends),
    });
    return json['result'];
  }
}
