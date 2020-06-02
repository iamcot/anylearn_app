import 'package:anylearn/dto/hot_users_dto.dart';
import 'package:equatable/equatable.dart';

import 'feature_data_dto.dart';
import 'item_dto.dart';

class HomeDTO extends Equatable {
  List<FeatureDataDTO> featuresIcons;
  List<HotUsersDTO> hotItems;
  List<String> banners;
  List<ItemDTO> monthCourses;

  HomeDTO({this.banners, this.featuresIcons, this.hotItems, this.monthCourses});

  @override
  List<Object> get props => [featuresIcons, hotItems, banners, monthCourses];

  static HomeDTO fromJson(dynamic json) {
    return json == null
        ? null
        : HomeDTO(
            banners: List<String>.from(json['banners']),
            hotItems: List<HotUsersDTO>.from(json['hot_items']?.map((v) => v == null ? null : HotUsersDTO.fromJson(v)))
                .toList(),
            monthCourses:
                List<ItemDTO>.from(json['month_courses']?.map((v) => v == null ? null : ItemDTO.fromJson(v))).toList(),
          );
  }
}
