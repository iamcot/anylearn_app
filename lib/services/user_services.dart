import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:anylearn/dto/profile/action_dto.dart';
import 'package:anylearn/dto/profile/post_dto.dart';
import 'package:anylearn/dto/picture_dto.dart';
import 'package:anylearn/dto/profile/profile_dto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../dto/account_calendar_dto.dart';
import '../dto/class_registered_user.dart';
import '../dto/contract.dart';
import '../dto/friends_dto.dart';
import '../dto/notification_dto.dart';
import '../dto/pending_order_dto.dart';
import '../dto/user_doc_dto.dart';
import '../dto/user_dto.dart';
import '../dto/users_dto.dart';
import '../main.dart';
import 'base_service.dart';

class UserService extends BaseService {
  final http.Client httpClient;
  final AppConfig config;

  UserService({required this.config, required this.httpClient});

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

  Future<UserDTO> loginFacebook(Map<String, dynamic> data) async {
    final url = buildUrl(appConfig: config, endPoint: "/login/facebook");
    data['notify_token'] = notifToken;
    final json = await post(httpClient, url, data);
    return UserDTO.fromJson(json);
  }

  Future<UserDTO> loginApple(Map<String, dynamic> data) async {
    final url = buildUrl(appConfig: config, endPoint: "/login/apple");
    data['notify_token'] = notifToken;
    final json = await post(httpClient, url, data);
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
    final url =
        buildUrl(appConfig: config, endPoint: "/user-less", token: token);
    print(url);
    final json = await get(httpClient, url);
    return UserDTO.fromJson(json);
  }

  Future<UsersDTO> getList(String role, int page, int pageSize) async {
    final url = buildUrl(
        appConfig: config,
        endPoint: "/users/$role",
        query: buildQuery({"page": page, "pageSize": pageSize}));
    final json = await get(httpClient, url);
    return UsersDTO.fromJson(json);
  }

  Future<bool> updateInfo(UserDTO user) async {
    final url =
        buildUrl(appConfig: config, endPoint: "/user/edit", token: user.token);
    final json = await post(httpClient, url, {
      "name": user.name,
      "refcode": user.refcode,
      "title": user.title,
      "introduce": user.introduce,
      "phone": user.phone,
      "email": user.email,
      "address": user.address,
      "country": user.country,
      "full_content": user.fullContent,
    });
    return json["result"];
  }

  Future<bool> changePass(
      String token, String newPassword, String oldPassword) async {
    final url =
        buildUrl(appConfig: config, endPoint: "/user/changepass", token: token);
    final json = await post(httpClient, url, {
      "newpass": newPassword,
      "oldpass": oldPassword,
    });
    return json["result"];
  }

  Future<UserDTO> register(String phone, String name, String password,
      String refcode, String role) async {
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
    final url = buildUrl(
        appConfig: config, endPoint: "/user/upload-image/$type", token: token);
    final rs = await postImage(url, file);
    return rs;
  }

  Future<FriendsDTO> friends(String token, int userId) async {
    final url =
        buildUrl(appConfig: config, endPoint: "/friends/$userId", token: token);
    final json = await get(httpClient, url);
    return FriendsDTO.fromJson(json);
  }

  Future<AccountCalendarDTO> myCalendar(String token) async {
    final url =
        buildUrl(appConfig: config, endPoint: "/user/mycalendar", token: token);
    print(url);
    final json = await get(httpClient, url);
    return AccountCalendarDTO.fromJson(json);
  }

  Future<int> joinCourse(String token, int itemId, int childId) async {
    final url = buildUrl(
        appConfig: config,
        endPoint: "/user/join/$itemId",
        token: token,
        query: "child=$childId");
    final json = await get(httpClient, url);
    return json['result'];
  }

  Future<List<ClassRegisteredUserDTO>> registeredUsers(
      String token, int itemId) async {
    final url = buildUrl(
        appConfig: config,
        endPoint: "/user/course-registered-users/$itemId",
        token: token);
    print(url);
    final json = await get(httpClient, url);
    return List<ClassRegisteredUserDTO>.from(json?.map(
        (e) => e == null ? null : ClassRegisteredUserDTO.fromJson(e))).toList();
  }

  Future<List<UserDocDTO>> getDocs(String token) async {
    final url =
        buildUrl(appConfig: config, endPoint: "/user/get-docs", token: token);
    final json = await get(httpClient, url);
    return List<UserDocDTO>.from(
        json?.map((e) => e == null ? null : UserDocDTO.fromJson(e))).toList();
  }

  Future<List<UserDocDTO>> addDoc(String token, File file) async {
    final url =
        buildUrl(appConfig: config, endPoint: "/user/add-doc", token: token);
    final jsonStr = await postImage(url, file);
    final rs = json.decode(jsonStr);
    return List<UserDocDTO>.from(
        rs?.map((e) => e == null ? null : UserDocDTO.fromJson(e))).toList();
  }

  Future<List<UserDocDTO>> removeDoc(String token, int fileId) async {
    final url = buildUrl(
        appConfig: config, endPoint: "/user/remove-doc/$fileId", token: token);
    final json = await get(httpClient, url);
    return List<UserDocDTO>.from(
        json?.map((e) => e == null ? null : UserDocDTO.fromJson(e))).toList();
  }

  Future<NotificationPagingDTO> notification(String token) async {
    final url = buildUrl(
        appConfig: config, endPoint: "/user/notification", token: token);
    final json = await get(httpClient, url);
    return NotificationPagingDTO.fromJson(json);
  }

  Future<void> notifRead(String token, int id) async {
    final url = buildUrl(
        appConfig: config,
        endPoint: "/user/notification/" + id.toString(),
        token: token);
    // print(url);
    await get(httpClient, url);
    return;
  }

  Future<List<UserDTO>> allFriends(String token) async {
    final url = buildUrl(
        appConfig: config, endPoint: "/user/all-friends", token: token);
    final json = await get(httpClient, url);
    return List<UserDTO>.from(
        json?.map((e) => e == null ? null : UserDTO.fromJson(e))).toList();
  }

  Future<bool> shareFriends(
      String token, int id, List<int> friends, bool isALL) async {
    final url =
        buildUrl(appConfig: config, endPoint: "/item/$id/share", token: token);
    final json = await post(httpClient, url, {
      "friends": isALL ? "ALL" : jsonEncode(friends),
    });
    return json['result'];
  }

  Future<bool> saveContract(String token, ContractDTO contract) async {
    final url =
        buildUrl(appConfig: config, endPoint: "/user/contract", token: token);
    final json = await post(httpClient, url, {
      "contract": jsonEncode(contract),
    });
    return json['result'];
  }

  Future<ContractDTO> loadContract(String token, int contractId) async {
    final url = buildUrl(
        appConfig: config,
        endPoint: "/user/contract/$contractId",
        token: token);
    final json = await get(httpClient, url);
    final contract = ContractDTO.fromJson(json);
    print(contract);
    return contract;
  }

  Future<bool> signContract(String token, int contractId) async {
    final url = buildUrl(
        appConfig: config,
        endPoint: "/user/contract/sign/$contractId",
        token: token);
    final json = await get(httpClient, url);
    return json['result'];
  }

  Future<int> saveChildren(
      String token, int id, String name, String dob) async {
    final url =
        buildUrl(appConfig: config, endPoint: "/user/childrenv2", token: token);
    final json = await post(httpClient, url, {
      "id": id.toString(),
      "name": name,
      "dob": dob,
    });
    return json['result'];
  }

  Future<List<UserDTO>> getChildren(String token) async {
    final url =
        buildUrl(appConfig: config, endPoint: "/user/children", token: token);
    final json = await get(httpClient, url);
    return List<UserDTO>.from(
        json?.map((e) => e == null ? null : UserDTO.fromJson(e))).toList();
  }

  Future<bool> sentOtp(String phone) async {
    final url = buildUrl(
        appConfig: config,
        endPoint: "/password/otp",
        query: buildQuery({"phone": phone}));
    final json = await get(httpClient, url);
    return json['result'];
  }
  // Future<bool> resentOtp(String phone) async {
  //   final url = buildUrl(
  //       appConfig: config,
  //       endPoint: "/password/otp",
  //       query: buildQuery({"phone": phone}));
  //   final json = await get(httpClient, url);
  //   return json['result'];
  // }

  Future<bool> resetOtp(
      String phone, String otp, String password, String passwordConfirm) async {
    final url = buildUrl(appConfig: config, endPoint: "/password/reset");
    final json = await post(httpClient, url, {
      "phone": phone,
      "otp": otp,
      "password": password,
      "password_confirmation": passwordConfirm,
    });
    return json['result'];
  }

  // Future<bool> checkOtp(String otp) async {
  //   final url = buildUrl(
  //       appConfig: config,
  //       endPoint: "/password/otp/check",
  //       query: buildQuery({"otp": otp}));
  //   final json = await get(httpClient, url);
  //   return json['result'];
  // }
  Future<bool> checkOtp(String otp, String phone) async {
    final url = buildUrl(appConfig: config, endPoint: "/otp/check");
    final json = await post(httpClient, url, {
      "phone": phone,
      "otp": otp,
      // "password": password,
      // "password_confirmation": passwordConfirm,
    });
    return json['result'];
  }

  Future<List<PendingOrderDTO>> pendingOrderConfigs(String token) async {
    final url = buildUrl(
      appConfig: config,
      endPoint: "/user/pending-orders",
      token: token,
    );
    print(url);
    final json = await get(httpClient, url);
    return List<PendingOrderDTO>.from(
            json?.map((e) => e == null ? null : PendingOrderDTO.fromJson(e)))
        .toList();
  }

  Future<bool> deleteAccount(String token) async {
    final url =
        buildUrl(appConfig: config, endPoint: "/user/delete", token: token);
    final json = await get(httpClient, url);
    return json['result'];
  }

  Future<bool> actionUser(String token) async {
    // final url = buildUrl(appConfig: config, endPoint: ,token: token);
    // final json = await get(httpClient,url);

    return true;
  }

  Future<ProfileDTO> getProfile(int userId) async {
    // final url = buildUrl(appConfig: config, endPoint: "/user/profile/$userId");
    // final json = await get(httpClient, url);
    // return UserDTO.fromJson(json);
    return ProfileDTO(
        profile: UserDTO(id: 8873, name: "Ngô Hiếu Phát"),
        posts: PostPagingDTO(
          currentPage: 1,
          data: [
            PostDTO(
              id: 1,
              status: 1,
              title: "Bạn đã đăng ký khóa học ABC",
              description: "Khóa học ABC là của XYZ, rất bổ ích cho trẻ nhỏ",
              user: UserDTO(name: "Ngô Hiếu Phát"),
              likeCounts: 20,
              commentCounts: 15765,
              shareCounts: 13233,
              // likes: [100],
              // share: 100,
            ),
            PostDTO(
              id: 2,
              status: 1,
              title: "Bạn đã đăng ký khóa học ABC 2",
              description: "Khóa học ABC 2 là của XYZ, rất bổ ích cho trẻ nhỏ",
              user: UserDTO(name: "Ngô Hiếu Phát"),
              likeCounts: 1234,
              commentCounts: 1323,
              shareCounts: 1323,
            ),
          ],
        ));
  }

  Future<PostPagingDTO> accountPost(int id, int page) async {
    // final url = buildUrl(appConfig: config, endPoint: ,token: token );
    // final json = await get(httpClient,url);

    return PostPagingDTO(
      currentPage: 2,
      data: [
        PostDTO(
          id: 1,
          status: 1,
          title: "Bạn đã đăng ký khóa học ABC",
          description: "Khóa học ABC là của XYZ, rất bổ ích cho trẻ nhỏ",
          user: UserDTO(id: 1, name: "Bạn"),
          comments: [],
          likeCounts: 2,
        ),
        PostDTO(
          id: 2,
          status: 1,
          title: "Bạn đã đăng ký khóa học ABC 2",
          description: "Khóa học ABC 2 là của XYZ, rất bổ ích cho trẻ nhỏ",
          user: UserDTO(id: 1, name: "Bạn"),
          comments: [],
          likeCounts: 100,
        ),
      ],
    );
  }

  Future<PostDTO> postContent(int id) async {
    return PostDTO(
      id: 1,
      status: 1,
      title: "Bạn đã đăng ký khóa học ABC",
      description: "Khóa học ABC là của XYZ, rất bổ ích cho trẻ nhỏ",
      user: UserDTO(id: 1, name: "Bạn"),
      comments: [],
      likeCounts: 2,
    );
  }
}
