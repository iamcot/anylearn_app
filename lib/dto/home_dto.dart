import 'package:equatable/equatable.dart';

import 'feature_data_dto.dart';
import 'hot_items_dto.dart';
import 'item_dto.dart';

class HomeDTO extends Equatable {
  List<FeatureDataDTO> featuresIcons;
  List<HotItemsDTO> hotItems;
  List<String> banners;
  List<ItemDTO> monthCourses;

  HomeDTO({this.banners, this.featuresIcons, this.hotItems, this.monthCourses});

  @override
  List<Object> get props => [featuresIcons,  hotItems, banners, monthCourses];

  static HomeDTO fromJson(dynamic json) {
    return json == null
        ? null
        : HomeDTO(
            banners: List<String>.from(json['banners']),
            hotItems: List<HotItemsDTO>.from(json['hot_items']?.map((v) => v == null ? null : HotItemsDTO.fromJson(v))).toList(),
            monthCourses: List<ItemDTO>.from(json['month_courses']?.map((v) => v == null ? null : ItemDTO.fromJson(v))).toList(),
          );
  }
}