import 'package:equatable/equatable.dart';

import 'item_dto.dart';
import 'user_doc_dto.dart';

class UserDTO extends Equatable {
   final id;
  String name;
  String title;
  String phone;
  String role;
  String image;
  String banner;
  String address;
  final walletM;
  final walletC;
  final userId;
  final commissionRate;
  String country;
  String dob;
  String email;
  final expire;
  String introduce;
  final isHot;
  final numFriends;
  String refcode;
  final status;
  final updateDoc;
  final route;
  final rating;
  String password;
  String token;
  String refLink;
  String fullContent;
  final docs;
  String dobPlace;
  int isSigned;
  final enableIosTrans;
  final disableAnypoint;
  final registered;
  final faved;
  final rated;
  List<UserDTO>? children;
  final cartcount;
  int inRegisterClassId;

  UserDTO({
    this.id,
    this.name = "",
    this.phone = "",
    this.title = "",
    this.role = "",
    this.image = "",
    this.banner = "",
    this.address = "",
    this.walletM = 0,
    this.walletC = 0,
    this.userId,
    this.commissionRate,
    this.country = "",
    this.dob = "",
    this.email = "",
    this.expire,
    this.introduce = "",
    this.isHot,
    this.numFriends,
    this.refcode = "",
    this.status,
    this.updateDoc,
    this.route = "",
    this.rating = 0.0,
    this.password = "",
    this.token = "",
    this.refLink = "",
    this.fullContent = "",
    this.docs = "",
    this.isSigned = 0,
    this.dobPlace = "",
    this.enableIosTrans,
    this.disableAnypoint,
    this.registered = "",
    this.faved = "",
    this.rated = "",
    this.children,
    this.cartcount = 0,
    this.inRegisterClassId = 0,
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
        isSigned,
        dobPlace,
        enableIosTrans,
        disableAnypoint,
        registered,
        faved,
        rated,
        cartcount,
        inRegisterClassId,
      ];

  @override
  String toString() => 'UserDTO {id: $id, name: $name, phone: $phone}';

  static UserDTO fromJson(dynamic json) {
    return json != ""
        ? UserDTO(
            id: json['id'] ?? 0,
            name: json['name'] ?? "",
            email: json['email'] ?? "",
            phone: json['phone'] ?? "",
            refcode: json['refcode'] ?? "",
            token: json['api_token'] ?? "",
            role: json['role'] ?? "",
            status: json['status'] ?? "",
            updateDoc: json['update_doc'] ?? "",
            expire: json['expire'] ?? "",
            walletC: json['wallet_c'] ?? "",
            walletM: json['wallet_m'] ?? "",
            commissionRate: json['commission_rate'] ?? "",
            userId: json['user_id'] ?? "",
            isHot: json['is_hot'] ?? "",
            image: json['image'] ?? "",
            banner: json['banner'] ?? "",
            introduce: json['introduce'] ?? "",
            title: json['title'] ?? "",
            dob: json['dob'] ?? "",
            address: json['address'] ?? "",
            country: json['country'] ?? "",
            numFriends: json['num_friends'] ?? "",
            refLink: json['reflink'] ?? "",
            fullContent: json['full_content'] ?? "",
            cartcount: json['cartcount'] == null ? 0 : json['cartcount'],
            docs: json['docs'] == null
                ? []
                : List<UserDocDTO>.from(json['docs']?.map((e) => e == null ? null : UserDocDTO.fromJson(e))).toList(),
            isSigned: json['is_signed'] ?? 0,
            dobPlace: json['dob_place'] ?? "",
            rating: json['rating'] == null ? 0.0 : double.parse(json['rating'].toString()),
            enableIosTrans: json['ios_transaction'] == null ? false : (json['ios_transaction'] == 1),
            disableAnypoint: json['disable_anypoint'] == null ? false : (json['disable_anypoint'] == 1),
            registered: json['registered'] == null
                ? []
                : List<ItemDTO>.from(json['registered']?.map((e) => e == null ? null : ItemDTO.fromJson(e))).toList(),
            faved: json['faved'] == null
                ? []
                : List<ItemDTO>.from(json['faved']?.map((e) => e == null ? null : ItemDTO.fromJson(e))).toList(),
            rated: json['rated'] == null
                ? []
                : List<ItemDTO>.from(json['rated']?.map((e) => e == null ? null : ItemDTO.fromJson(e))).toList(),
            children: json['children'] == null
                ? []
                : List<UserDTO>.from(json['children']?.map((e) => e == null ? null : UserDTO.fromJson(e))).toList(),
          )
        : UserDTO();
  }
}
