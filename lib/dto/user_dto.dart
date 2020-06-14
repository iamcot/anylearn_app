import 'package:equatable/equatable.dart';

import 'user_doc_dto.dart';

class UserDTO extends Equatable {
  final int id;
  String name;
  String title;
  String phone;
  String role;
  String image;
  String banner;
  String address;
  final int walletM;
  final int walletC;
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
  String refLink;
  String fullContent;
  final List<UserDocDTO> docs;

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
    this.refLink,
    this.fullContent,
    this.docs,
  });

  @override
  List<Object> get props => [
        id,
        name,
        phone,
        title,
        role,
        image,
        banner,
        address,
        walletM,
        walletC,
        userId,
        commissionRate,
        country,
        dob,
        email,
        expire,
        introduce,
        isHot,
        numFriends,
        refcode,
        updateDoc,
        route,
        rating,
        token,
        status,
        refLink,
        fullContent,
        docs,
      ];

  @override
  String toString() => 'UserDTO {id: $id, name: $name, phone: $phone}';

  static UserDTO fromJson(dynamic json) {
    return json != null
        ? UserDTO(
            id: json['id'],
            name: json['name'],
            email: json['email'],
            phone: json['phone'],
            refcode: json['refcode'],
            token: json['api_token'],
            role: json['role'],
            status: json['status'],
            updateDoc: json['update_doc'],
            expire: json['expire'],
            walletC: json['wallet_c'],
            walletM: json['wallet_m'],
            commissionRate: json['commission_rate'],
            userId: json['user_id'],
            isHot: json['is_hot'],
            image: json['image'],
            banner: json['banner'],
            introduce: json['introduce'],
            title: json['title'],
            dob: json['dob'],
            address: json['address'],
            country: json['country'],
            numFriends: json['num_friends'],
            refLink: json['reflink'],
            fullContent: json['full_content'],
            docs: json['docs'] == null ? null : List<UserDocDTO>.from(json['docs']?.map((e) => e == null ? null : UserDocDTO.fromJson(e))).toList(),
          )
        : null;
  }
}
