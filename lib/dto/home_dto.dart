import 'package:anylearn/dto/article_dto.dart';
import 'package:anylearn/dto/home_config_dto.dart';
import 'package:anylearn/dto/hot_users_dto.dart';
import 'package:equatable/equatable.dart';

import 'feature_data_dto.dart';
import 'item_dto.dart';

class HomeDTO extends Equatable {
  List<FeatureDataDTO> featuresIcons;
  List<HotUsersDTO> hotItems;
  List<String> banners;
  List<ItemDTO> monthCourses;
  final HomeConfigDTO config;
  final List<ArticleDTO> articles;
  final List<ArticleDTO> videos;
  final homeClasses;
  final List<HomeBannerDTO> homeBanner;

  HomeDTO({
    this.banners,
    this.featuresIcons,
    this.hotItems,
    this.monthCourses,
    this.config,
    this.articles,
    this.videos,
    this.homeClasses,
    this.homeBanner,
  });

  @override
  List<Object> get props => [featuresIcons, hotItems, banners, monthCourses, config, articles, homeClasses, videos, homeBanner];

  static HomeDTO fromJson(dynamic json) {
    return json == null
        ? null
        : HomeDTO(
            banners: List<String>.from(json['banners']),
            homeBanner: json['new_banners'] == null ? null : List<HomeBannerDTO>.from(json['new_banners']?.map((v) => v == null ? null : HomeBannerDTO.fromJson(v))).toList(),
            hotItems: List<HotUsersDTO>.from(json['hot_items']?.map((v) => v == null ? null : HotUsersDTO.fromJson(v)))
                .toList(),
            monthCourses:
                List<ItemDTO>.from(json['month_courses']?.map((v) => v == null ? null : ItemDTO.fromJson(v))).toList(),
            config: json['articles'] == null ? null : HomeConfigDTO.fromJson(json['configs']),
            articles: json['articles'] == null
                ? null
                : List<ArticleDTO>.from(json['articles']?.map((e) => e == null ? null : ArticleDTO.fromJson(e)))
                    .toList(),
            videos: json['videos'] == null
                ? null
                : List<ArticleDTO>.from(json['videos']?.map((e) => e == null ? null : ArticleDTO.fromJson(e))).toList(),
            homeClasses: json['home_classes'] == null
                ? null
                : List<HomeClassesDTO>.from(
                    json['home_classes']?.map((v) => v == null ? null : HomeClassesDTO.fromJson(v))).toList(),
          );
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
