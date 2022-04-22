import 'package:equatable/equatable.dart';

import 'article_dto.dart';
import 'feature_data_dto.dart';
import 'home_config_dto.dart';
import 'item_dto.dart';
import 'items_paging_dto.dart';

class HomeDTO extends Equatable {
  List<FeatureDataDTO> featuresIcons;
  final config;
  final articles;
  final promotions;
  final events;
  final homeClasses;
  final homeBanner;
  final categories;

  HomeDTO({
    required this.featuresIcons,
    this.config,
    this.articles,
    required this.homeClasses,
    this.homeBanner,
    this.promotions,
    this.events,
    this.categories,
  });

  @override
  List<Object> get props => [featuresIcons, config, articles, homeClasses, homeBanner, promotions, events, categories];

  static HomeDTO fromJson(dynamic json) {
    return json == ""
        ? HomeDTO(featuresIcons: [], homeClasses: [])
        : HomeDTO(
            featuresIcons: [],
            homeBanner: json['new_banners'] == null
                ? []
                : List<HomeBannerDTO>.from(
                    json['new_banners']?.map((v) => v == null ? null : HomeBannerDTO.fromJson(v))).toList(),
            config: json['articles'] == null ? null : HomeConfigDTO.fromJson(json['configs']),
            articles: json['articles'] == null
                ? []
                : List<ArticleDTO>.from(json['articles']?.map((e) => e == null ? null : ArticleDTO.fromJson(e)))
                    .toList(),
            promotions: json['promotions'] == null
                ? []
                : List<ArticleDTO>.from(json['promotions']?.map((e) => e == null ? null : ArticleDTO.fromJson(e)))
                    .toList(),
            events: json['events'] == null
                ? []
                : List<ArticleDTO>.from(json['events']?.map((e) => e == null ? null : ArticleDTO.fromJson(e))).toList(),
            homeClasses: json['home_classes'] == null
                ? []
                : List<HomeClassesDTO>.from(
                    json['home_classes']?.map((v) => v == null ? null : HomeClassesDTO.fromJson(v))).toList(),
            categories: json['home_classes'] == null ? [] :
                List<CategoryDTO>.from(json['categories']?.map((v) => v == null ? null : CategoryDTO.fromJson(v)))
                    .toList());
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
            items: List<ItemDTO>.from(json['items']?.map((v) => v == null ? null : ItemDTO.fromJson(v))).toList(),
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
