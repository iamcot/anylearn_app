class UserDTO {
  final int id;
  String name;
  String title;
  String phone;
  String role;
  String image;
  String banner;
  String address;
  final double walletM;
  final double walletC;
  final int userId;
  final double commissionRate;
  String country;
  String dob;
  String email;
  final int expire;
  String introduce;
  final int isHot;
  final int numFriends;
  String refcode;
  final int status;
  final int updateDoc;
  final String route;
  final double rating;
  String password;
  String token;

  UserDTO({
    this.id,
    this.name,
    this.phone,
    this.title,
    this.role,
    this.image,
    this.banner,
    this.address,
    this.walletM,
    this.walletC,
    this.userId,
    this.commissionRate,
    this.country,
    this.dob,
    this.email,
    this.expire,
    this.introduce,
    this.isHot,
    this.numFriends,
    this.refcode,
    this.status,
    this.updateDoc,
    this.route,
    this.rating,
    this.password,
    this.token,
  });
}
