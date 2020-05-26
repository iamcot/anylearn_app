import 'feature_data_dto.dart';
import 'hot_items_dto.dart';
import 'item_dto.dart';

class HomeDTO {
  List<FeatureDataDTO> featuresIcons;
  List<HotItemsDTO> hotItems;
  List<String> banners;
  List<ItemDTO> monthCourses;

  HomeDTO({this.banners, this.featuresIcons, this.hotItems, this.monthCourses});
}