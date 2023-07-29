import 'package:anylearn/dto/article_dto.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/dto/v3/home_dto.dart';
import 'package:anylearn/dto/hot_items_dto.dart';
import 'package:equatable/equatable.dart';

//import '../article_dto.dart';
//import '../hot_items_dto.dart';

class SubtypeDTO extends Equatable {
  final j4u;
  final repurchaseds;
  final categories;
  final categoryItems;
  final partners;
  final partnerItems;
  final vouchers;

  SubtypeDTO({
    this.j4u,
    this.repurchaseds,
    this.categories,
    this.categoryItems,
    this.partners,
    this.partnerItems,
    this.vouchers,
  });

  @override
  List<Object> get props => [
    j4u,
    repurchaseds,
    categories,
    categoryItems,
    partners,
    partnerItems,
    vouchers,
  ];

  factory SubtypeDTO.fromJson(Map<String, dynamic> json) {
    return json == null
      ? SubtypeDTO()
      : SubtypeDTO(
        j4u: json['j4u'] == null || json['j4u'].isEmpty
          ? HotItemsDTO(route: '', title: '', list: []) 
          : HotItemsDTO.fromJson(json['j4u']),
        repurchaseds: json['repurchases'] == null || json['repurchases'].isEmpty
          ? HotItemsDTO(route: '', title: '', list: []) 
          : HotItemsDTO.fromJson(json['repurchases']),
        categories: json['categories'] == null 
          ? [] 
          : List<CategoryDTO>
            .from(json['categories']?.map((v) => v == null ? null : CategoryDTO.fromJson(v)))
            .toList(),
        categoryItems: json['categoryItems'] == null 
          ? []
          : List<HomeClassesDTO>
            .from(json['categoryItems']?.map((v) => v == null? null : HomeClassesDTO.fromJson(v)))
            .toList(),
        partners: json['partners']  == null 
          ? [] 
          : List<UserDTO>
            .from(json['partners']?.map((v) => v == null ? null : UserDTO.fromJson(v)))
            .toList(),
        partnerItems: json['partnerItems'] == null
          ? []
          : List<HomeClassesDTO>
            .from(json['partnerItems']?.map((v) => v == null ? null : HomeClassesDTO.fromJson(v)))
            .toList(),
        vouchers: json['vouchers'] == null 
          ? []
          : List<ArticleDTO>
            .from(json['vouchers']?.map((v) => v == null ? null : ArticleDTO.fromJson(v)))
            .toList(),
      );
  }

  /*static SubtypeDTO fromJson(dynamic json) {
    return json == ""
        ? SubtypeDTO()
        : SubtypeDTO(
            j4u: json['j4u'] == null ? HotItemsDTO() : HotItemsDTO.fromJson(json['j4u']),
            repurchaseds: json['repurchaseds'] == null ? HotItemsDTO() : HotItemsDTO.fromJson(json['repurchaseds']),
            promotions: json['promotions'] == null
                ? []
                : List<ArticleDTO>.from(json['promotions']?.map((e) => e == null ? null : ArticleDTO.fromJson(e)))
                    .toList(),
            recommendations:
                json['recommendations'] == null ? HotItemsDTO() : HotItemsDTO.fromJson(json['recommendations']),
            vouchers: json['vouchers'] == null
                ? []
                : List<ArticleDTO>.from(json['vouchers']?.map((v) => v == null ? null : ArticleDTO.fromJson(v)))
                    .toList(),
            classes: json['classes'] == null
                ? []
                : List<HomeClassesDTO>.from(json['classes']?.map((v) => v == null ? null : HomeClassesDTO.fromJson(v)))
                    .toList(),
            categories: json['categories'] == null
                ? []
                : List<CategoryDTO>.from(json['categories']?.map((v) => v == null ? null : CategoryDTO.fromJson(v)))
                    .toList(),
            partners: [],
          );
  }*/
}