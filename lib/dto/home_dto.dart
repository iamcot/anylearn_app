import 'package:equatable/equatable.dart';

import 'article_dto.dart';
import 'feature_data_dto.dart';
import 'home_config_dto.dart';
import 'item_dto.dart';
import 'items_paging_dto.dart';

class HomeDTO extends Equatable {
  List<FeatureDataDTO> featuresIcons;
  final HomeConfigDTO config;
  final List<ArticleDTO> articles;
  final List<ArticleDTO> promotions;
  final List<ArticleDTO> events;
  final List<HomeClassesDTO> homeClasses;
  final List<HomeBannerDTO> homeBanner;
  final List<CategoryDTO> categories;

  HomeDTO({
    this.featuresIcons,
    this.config,
    this.articles,
    this.homeClasses,
    this.homeBanner,
    this.promotions,
    this.events,
    this.categories,
  });

  @override
  List<Object> get props => [featuresIcons, config, articles, homeClasses, homeBanner, promotions, events, categories];

  static HomeDTO fromJson(dynamic json) {
    return json == null
        ? null
        : HomeDTO(
            homeBanner: json['new_banners'] == null
                ? null
                : List<HomeBannerDTO>.from(
                    json['new_banners']?.map((v) => v == null ? null : HomeBannerDTO.fromJson(v))).toList(),
            config: json['articles'] == null ? null : HomeConfigDTO.fromJson(json['configs']),
            articles: json['articles'] == null
                ? null
                : List<ArticleDTO>.from(json['articles']?.map((e) => e == null ? null : ArticleDTO.fromJson(e)))
                    .toList(),
            promotions: json['promotions'] == null
                ? null
                : List<ArticleDTO>.from(json['promotions']?.map((e) => e == null ? null : ArticleDTO.fromJson(e)))
                    .toList(),
            events: json['events'] == null
                ? null
                : List<ArticleDTO>.from(json['events']?.map((e) => e == null ? null : ArticleDTO.fromJson(e))).toList(),
            homeClasses: json['home_classes'] == null
                ? null
                : List<HomeClassesDTO>.from(
                    json['home_classes']?.map((v) => v == null ? null : HomeClassesDTO.fromJson(v))).toList(),
            categories:
                List<CategoryDTO>.from(json['categories']?.map((v) => v == null ? null : CategoryDTO.fromJson(v)))
                    .toList());
  }
}

class HomeClassesDTO extends Equatable {
  final String title;
  final List<ItemDTO> classes;

  HomeClassesDTO({this.title, this.classes});

  @override
  List<Object> get props => [title, classes];

  static HomeClassesDTO fromJson(dynamic json) {
    return json == null
        ? null
        : HomeClassesDTO(
            title: json['title'],
            classes: List<ItemDTO>.from(json['classes']?.map((v) => v == null ? null : ItemDTO.fromJson(v))).toList(),
          );
  }
}

class HomeBannerDTO extends Equatable {
  final String file;
  final String route;
  final String arg;

  HomeBannerDTO({this.file, this.route, this.arg});

  @override
  List<Object> get props => [file, route, arg];

  static HomeBannerDTO fromJson(dynamic json) {
    return json == null
        ? null
        : HomeBannerDTO(
            file: json['file'],
            route: json['route'],
            arg: json['arg'],
          );
  }
}

class CategoryDTO extends Equatable {
  final String title;
  final id;
  final List<ItemDTO> items;

  CategoryDTO({this.title, this.id, this.items});

  @override
  List<Object> get props => [
        id,
        title,
        items,
      ];

  static CategoryDTO fromJson(dynamic json) {
    return json == null
        ? null
        : CategoryDTO(
            id: json['id'],
            title: json['title'],
            items: List<ItemDTO>.from(json['items']?.map((v) => v == null ? null : ItemDTO.fromJson(v))).toList(),
          );
  }
}

class CategoryPagingDTO extends Equatable {
  final String title;
  final id;
  final ItemsPagingDTO items;

  CategoryPagingDTO({this.title, this.id, this.items});

  @override
  List<Object> get props => [
        id,
        title,
        items,
      ];

  static CategoryPagingDTO fromJson(dynamic json) {
    return json == null
        ? null
        : CategoryPagingDTO(
            id: json['id'],
            title: json['title'],
            items: ItemsPagingDTO.fromJson(json['items']),
          );
  }
}
