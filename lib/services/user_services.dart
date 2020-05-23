import '../dto/user_dto.dart';

class UserService {
  Future<UserDTO> login(String phone, String password) async {
    await Future.delayed(Duration(microseconds: 500));
    return UserDTO(
      name: "MC Hoài Trinh",
      refcode: "1900113",
      walletC: 100,
      walletM: 123400,
      numFriends: 99,
      image:
          "https://scontent.fvca1-2.fna.fbcdn.net/v/t1.0-9/89712877_1076973919331440_3222915485796401152_n.jpg?_nc_cat=107&_nc_sid=7aed08&_nc_ohc=d-jXcHVpNOEAX8IU-ED&_nc_ht=scontent.fvca1-2.fna&oh=f98801f09d0720e77e524fef83f6e472&oe=5EEA3ECF",
      token: "tokenxyz",
    );
  }

  Future<UserDTO> getInfo(String token) async {
    await Future.delayed(Duration(microseconds: 500));
    return UserDTO(
      name: "MC Hoài Trinh",
      refcode: "1900113",
      walletC: 100,
      walletM: 123400,
      numFriends: 99,
      image:
          "https://scontent.fvca1-2.fna.fbcdn.net/v/t1.0-9/89712877_1076973919331440_3222915485796401152_n.jpg?_nc_cat=107&_nc_sid=7aed08&_nc_ohc=d-jXcHVpNOEAX8IU-ED&_nc_ht=scontent.fvca1-2.fna&oh=f98801f09d0720e77e524fef83f6e472&oe=5EEA3ECF",
      token: "tokenxyz",
    );
  }

  Future<bool> updateInfo(UserDTO user) async {
    await Future.delayed(Duration(microseconds: 500));
    return true;
  }

  Future<bool> updatePassword(String oldPassword, String newPassword) async {
    await Future.delayed(Duration(microseconds: 500));
    return true;
  }
}
