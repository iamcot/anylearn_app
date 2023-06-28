import 'package:equatable/equatable.dart';

import '../article_dto.dart';
import '../hot_items_dto.dart';
import 'home_dto.dart';

class SubtypeDTO extends Equatable {
  final j4u;
  final repurchaseds;
  final promotions;
  final recommendations;
  final vouchers;
  final classes;
  final categories;
  final partners;

  SubtypeDTO({
    this.j4u,
    this.repurchaseds,
    this.recommendations,
    this.vouchers,
    this.classes,
    this.promotions,
    this.categories,
    this.partners,
  });

  @override
  List<Object> get props => [
        j4u,
        repurchaseds,
        recommendations,
        vouchers,
        classes,
        promotions,
        categories,
        partners,
      ];

  static SubtypeDTO fromJson(dynamic json) {
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
  }
}
