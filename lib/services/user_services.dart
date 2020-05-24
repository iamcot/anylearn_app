import '../dto/user_dto.dart';

class UserService {
  final mockData = {
    "1": UserDTO(
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
    await Future.delayed(Duration(microseconds: 500));
    //TODO MOCK
    return mockData[phone];
  }

  Future<UserDTO> getInfo(String token) async {
    await Future.delayed(Duration(microseconds: 500));
    //TODO MOCK
    return mockData[token];
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
