import 'dart:convert';

import '../app_config.dart';
import '../dto/user_dto.dart';
import '../dto/users_dto.dart';
import 'package:http/http.dart' as http;

class UserService {
  final http.Client httpClient;
  final AppConfig config;

  UserService({this.config, this.httpClient});
  final mockData = {
    "1": UserDTO(
      id: 1,
      name: "MC Hoài Trinh",
      refcode: "hoaitrinh",
      walletC: 100,
      walletM: 123400,
      numFriends: 99,
      role: "teacher",
      image:
          "https://scontent.fvca1-2.fna.fbcdn.net/v/t1.0-9/89712877_1076973919331440_3222915485796401152_n.jpg?_nc_cat=107&_nc_sid=7aed08&_nc_ohc=d-jXcHVpNOEAX8IU-ED&_nc_ht=scontent.fvca1-2.fna&oh=f98801f09d0720e77e524fef83f6e472&oe=5EEA3ECF",
      token: "1",
    ),
    "2": UserDTO(
      id: 2,
      name: "Quỳnh Như",
      refcode: "1900114",
      walletC: 0,
      walletM: 0,
      role: "member",
      title: "Sai vặt viên của anyLearn",
      numFriends: 10,
      image:
          "https://scontent.fvca1-2.fna.fbcdn.net/v/t1.0-9/73201494_660636241128219_2126988502150152192_o.jpg?_nc_cat=101&_nc_sid=85a577&_nc_ohc=XpqEYsumrWQAX_eSsvw&_nc_ht=scontent.fvca1-2.fna&oh=9bb968ff193e0365eac2b28bf23342b1&oe=5EE9D4D6",
      token: "2",
    ),
  };
  Future<UserDTO> login(String phone, String password) async {
    String url = config.apiUrl + config.loginEP + "?phone=$phone&password=$password";
    print(url);
    var json;
    try {
      final response = await this.httpClient.get(url);
      if (response.statusCode != 200) {
        return null;
      }
      json = jsonDecode(response.body);
      var user = UserDTO.fromJson(json);
      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<UserDTO> getInfo(String token) async {
    String url = config.apiUrl + config.userInfoEP + "?${config.tokenParam}=$token";
    print(url);
    var json;
   try {
      final response = await this.httpClient.get(url);
      if (response.statusCode != 200) {
        return null;
      }
      json = jsonDecode(response.body);
      return UserDTO.fromJson(json);
    } catch (error) {
      print(error);
      return null;
    }
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
