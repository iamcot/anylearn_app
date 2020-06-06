import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../dto/account_calendar_dto.dart';
import '../dto/const.dart';
import '../dto/friends_dto.dart';
import '../dto/user_dto.dart';
import '../services/config_services.dart';
import '../services/user_services.dart';

class UserRepository {
  UserService userService;
  ConfigServices configServices;
  final storage = new FlutterSecureStorage();
  final config;
  final httpClient = http.Client();

  UserRepository({this.config}) {
    userService = new UserService(httpClient: httpClient, config: config);
    configServices = new ConfigServices(httpClient: httpClient, config: config);
  }

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

  Future<UserDTO> register(String phone, String name, String password, String refcode, String role) async {
    return await userService.register(phone, name, password, refcode, role);
  }

  Future<String> uploadAvatar(File file, String token) async {
    return await userService.uploadUserImage("image", token, file);
  }

  Future<String> uploadBanner(File file, String token) async {
    return await userService.uploadUserImage("banner", token, file);
  }

  Future<bool> editUser(UserDTO user, String token) async {
    return await userService.updateInfo(user);
  }

  Future<FriendsDTO> friends(int userId, String token) async {
    return await userService.friends(token, userId);
  }

  Future<String> toc() async {
    final docDTO = await configServices.doc(MyConst.GUIDE_TOC);
    if (docDTO != null) {
      return docDTO.content;
    }
    return "";
  }

  Future<AccountCalendarDTO> myCalendar(String token) async {
    return await userService.myCalendar(token);
  }

  Future<int> joinCourse(String token, int itemId) async {
    return userService.joinCourse(token, itemId);
  }

  Future<List<UserDTO>> registeredUsers(String token, int itemId) async {
    return userService.registeredUsers(token, itemId);
  }
}
