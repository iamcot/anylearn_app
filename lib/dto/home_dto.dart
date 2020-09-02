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

  HomeDTO({this.banners, this.featuresIcons, this.hotItems, this.monthCourses, this.config, this.articles});

  @override
  List<Object> get props => [featuresIcons, hotItems, banners, monthCourses, config, articles];

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
          );
  }
}
