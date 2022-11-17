import 'dart:io';

import 'package:anylearn/dto/profilelikecmt/action_dto.dart';
import 'package:anylearn/dto/profilelikecmt/post_dto.dart';
import 'package:anylearn/dto/profilelikecmt/profile_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../dto/account_calendar_dto.dart';
import '../dto/class_registered_user.dart';
import '../dto/const.dart';
import '../dto/contract.dart';
import '../dto/friends_dto.dart';
import '../dto/notification_dto.dart';
import '../dto/pending_order_dto.dart';
import '../dto/user_doc_dto.dart';
import '../dto/user_dto.dart';
import '../services/config_services.dart';
import '../services/user_services.dart';

class UserRepository {
  late UserService userService;
  late ConfigServices configServices;
  final storage = new FlutterSecureStorage();
  final config;
  final httpClient = http.Client();

  UserRepository({this.config}) {
    userService = new UserService(httpClient: httpClient, config: config);
    configServices = new ConfigServices(httpClient: httpClient, config: config);
  }

  Future<UserDTO> getUser(String token, bool isFull) async {
    if (isFull) {
      return await userService.getInfo(token);
    }
    return await userService.getInfoLess(token);
  }

  Future<UserDTO> authenticated(
      {required String phone, required String password}) async {
    return await userService.login(phone, password);
  }

  Future<UserDTO> loginFacebook({required Map<String, dynamic> data}) async {
    return await userService.loginFacebook(data);
  }

  Future<UserDTO> loginApple({required Map<String, dynamic> data}) async {
    return await userService.loginApple(data);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: MyConst.AUTH_TOKEN);
    return;
  }

  Future<void> storeToken(String token) async {
    await storage.write(key: MyConst.AUTH_TOKEN, value: token);
    return;
  }

  Future<String?> getToken() async {
    return await storage.read(key: MyConst.AUTH_TOKEN);
  }

  Future<UserDTO> register(String phone, String name, String password,
      String refcode, String role) async {
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

  Future<bool> changePass(String token, String newPass, String oldPass) async {
    return await userService.changePass(token, newPass, oldPass);
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

  Future<int> joinCourse(String token, int itemId, int childId) async {
    return userService.joinCourse(token, itemId, childId);
  }

  Future<List<ClassRegisteredUserDTO>> registeredUsers(
      String token, int itemId) async {
    return userService.registeredUsers(token, itemId);
  }

  Future<ProfileDTO> getProfile(String token, int page) async {
    return userService.getProfile(token, page);
  }

  Future<List<UserDocDTO>> getDocs(String token) async {
    return userService.getDocs(token);
  }

  Future<List<UserDocDTO>> addDoc(String token, File file) async {
    return userService.addDoc(token, file);
  }

  Future<List<UserDocDTO>> removeDoc(String token, int fileId) async {
    return userService.removeDoc(token, fileId);
  }

  Future<NotificationPagingDTO> notification(String token) async {
    return userService.notification(token);
  }

  Future<void> notifRead(String token, int id) async {
    return userService.notifRead(token, id);
  }

  Future<void> logout(String token) async {
    return userService.logout(token);
  }

  Future<bool> saveContract(String token, ContractDTO contract) async {
    return await userService.saveContract(token, contract);
  }

  Future<ContractDTO> loadContract(String token, int contractId) async {
    return await userService.loadContract(token, contractId);
  }

  Future<bool> signContract(String token, int contractId) async {
    return await userService.signContract(token, contractId);
  }

  Future<int> saveChildren(
      String token, int id, String name, String dob) async {
    return await userService.saveChildren(token, id, name, dob);
  }

  Future<List<UserDTO>> getChildren(String token) async {
    return await userService.getChildren(token);
  }

  Future<bool> sentOtp(String phone) async {
    return await userService.sentOtp(phone);
  }

  Future<bool> ResentOtp(String phone) async {
    return await userService.sentOtp(phone);
  }

  Future<bool> resetOtp(
      String phone, String otp, String password, String passwordConfirm) async {
    return await userService.resetOtp(phone, otp, password, passwordConfirm);
  }

  Future<bool> checkOtp(String otp, String phone) async {
    return await userService.checkOtp(otp, phone);
  }

  Future<List<PendingOrderDTO>> dataPendingOrderPage(String token) async {
    return await userService.pendingOrderConfigs(token);
  }

  Future<bool> deleteAccount(String token) async {
    return await userService.deleteAccount(token);
  }

  Future<bool> actionUser(
      String token, int id, String type, String content) async {
    return await userService.actionUser(token, id, type, content);
  }

  Future<PostDTO> postContent(int id) async {
    return await userService.postContent(id);
  }

  Future<ProfileDTO> getFriendProfile(int userId, int page) async {
    return await userService.getFriendProfile(userId , page);
  }
}
