import '../ask_dto.dart';
import '../hot_items_dto.dart';
import 'voucher_dto.dart';
import 'package:equatable/equatable.dart';

import '../article_dto.dart';
import '../home_config_dto.dart';
import '../item_dto.dart';
import '../items_paging_dto.dart';

class HomeV3DTO extends Equatable {
  final configs;
  final pointBox;
  final j4u;
  final repurchaseds;
  final banners;
  final promotions;
  final recommendations;
  final vouchers;
  final asks;
  final classes;
  final articles;
  final categories;

  HomeV3DTO({
    this.configs,
    this.pointBox,
    this.j4u,
    this.repurchaseds,
    this.banners,
    this.recommendations,
    this.vouchers,
    this.asks,
    this.classes,
    this.articles,
    this.promotions,
    this.categories,
  });

  @override
  List<Object> get props => [
        configs,
        pointBox,
        j4u,
        repurchaseds,
        banners,
        recommendations,
        vouchers,
        asks,
        classes,
        articles,
        promotions,
        categories
      ];

  static HomeV3DTO fromJson(dynamic json) {
    return json == ""
        ? HomeV3DTO()
        : HomeV3DTO(
            configs: json['configs'] == null ? HomeConfigDTO() : HomeConfigDTO.fromJson(json['configs']),
            pointBox: json["pointBox"] == null ? PointBoxDTO() : PointBoxDTO.fromJson(json['pointBox']),
            j4u: json['j4u'] == null ? HotItemsDTO() : HotItemsDTO.fromJson(json['j4u']),
            repurchaseds: json['repurchaseds'] == null ? HotItemsDTO() : HotItemsDTO.fromJson(json['repurchaseds']),
            banners: json['banners'] == null
                ? []
                : List<HomeBannerDTO>.from(json['banners']?.map((v) => v == null ? null : HomeBannerDTO.fromJson(v)))
                    .toList(),
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
            articles: json['articles'] == null
                ? []
                : List<ArticleDTO>.from(json['articles']?.map((e) => e == null ? null : ArticleDTO.fromJson(e)))
                    .toList(),
            asks: json['asks'] == null ? [] : AskDTO.fromJson(json['asks']),
            classes: json['classes'] == null
                ? []
                : List<HomeClassesDTO>.from(json['classes']?.map((v) => v == null ? null : HomeClassesDTO.fromJson(v)))
                    .toList(),
            categories: json['categories'] == null
                ? []
                : List<CategoryDTO>.from(json['categories']?.map((v) => v == null ? null : CategoryDTO.fromJson(v)))
                    .toList()
                    );
  }
}

class HomeClassesDTO extends Equatable {
  final title;
  final classes;

  HomeClassesDTO({this.title, this.classes});

  @override
  List<Object> get props => [title, classes];

  static HomeClassesDTO fromJson(dynamic json) {
    return json == ""
        ? HomeClassesDTO()
        : HomeClassesDTO(
            title: json['title'],
            classes: List<ItemDTO>.from(json['classes']?.map((v) => v == null ? null : ItemDTO.fromJson(v))).toList(),
          );
  }
}

class PointBoxDTO extends Equatable {
  final anypoint;
  final goingClass;
  final ratingClass;

  PointBoxDTO({this.anypoint, this.goingClass, this.ratingClass});

  @override
  List<Object> get props => [anypoint, goingClass, ratingClass];

  static PointBoxDTO fromJson(dynamic json) {
    return json == ""
        ? PointBoxDTO()
        : PointBoxDTO(
            anypoint: json['anypoint'],
            goingClass: json['goingClass'],
            ratingClass: json['ratingClass'],
          );
  }
}

class HomeBannerDTO extends Equatable {
  final file;
  final route;
  final arg;

  HomeBannerDTO({this.file, this.route, this.arg});

  @override
  List<Object> get props => [file, route, arg];

  static HomeBannerDTO fromJson(dynamic json) {
    return json == ""
        ? HomeBannerDTO()
        : HomeBannerDTO(
            file: json['file'],
            route: json['route'],
            arg: json['arg'],
          );
  }
}

class CategoryDTO extends Equatable {
  final title;
  final id;
  final items;

  CategoryDTO({this.title, this.id, this.items});

  @override
  List<Object> get props => [
        id,
        title,
        items,
      ];

  static CategoryDTO fromJson(dynamic json) {
    return json == ""
        ? CategoryDTO()
        : CategoryDTO(
            id: json['id'],
            title: json['title'],
            items: json['items'] == null
                ? []
                : List<ItemDTO>.from(json['items']?.map((v) => v == null ? null : ItemDTO.fromJson(v))).toList(),
          );
  }
}

class CategoryPagingDTO extends Equatable {
  final title;
  final id;
  final items;

  CategoryPagingDTO({this.title, this.id, this.items});

  @override
  List<Object> get props => [
        id,
        title,
        items,
      ];

  static CategoryPagingDTO fromJson(dynamic json) {
    return json == ""
        ? CategoryPagingDTO()
        : CategoryPagingDTO(
            id: json['id'],
            title: json['title'],
            items: ItemsPagingDTO.fromJson(json['items']),
          );
  }
}
