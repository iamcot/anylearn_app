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

  HomeDTO({
    this.banners,
    this.featuresIcons,
    this.hotItems,
    this.monthCourses,
    this.config,
    this.articles,
    this.videos,
    this.homeClasses,
  });

  @override
  List<Object> get props => [featuresIcons, hotItems, banners, monthCourses, config, articles, homeClasses, videos];

  static HomeDTO fromJson(dynamic json) {
    return json == null
        ? null
        : HomeDTO(
            banners: List<String>.from(json['banners']),
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
