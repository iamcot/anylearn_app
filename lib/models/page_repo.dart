import 'package:anylearn/dto/feature_data_dto.dart';
import 'package:anylearn/models/default_feature_data.dart';

import '../dto/const.dart';
import '../dto/home_dto.dart';
import '../dto/items_dto.dart';
import '../dto/pdp_dto.dart';
import '../dto/users_dto.dart';
import '../services/config_services.dart';
import '../services/item_services.dart';
import '../services/user_services.dart';

class PageRepository {
  final userService = UserService();
  final itemService = ItemService();
  final configService = ConfigServices();

  Future<PdpDTO> dataPDP(int itemId) async {
    return await itemService.getPDPData(itemId);
  }

  Future<UsersDTO> dataTeachersPage(int page, int pageSize) async {
    return await userService.getList(MyConst.ROLE_TEACHER, page, pageSize);
  }

  Future<ItemsDTO> dataTeacherPage(int userId, int page, int pageSize) async {
    return await itemService.itemsListOfUser(userId, page, pageSize);
  }

  Future<UsersDTO> dataSchoolsPage(int page, int pageSize) async {
    return await userService.getList(MyConst.ROLE_SCHOOL, page, pageSize);
  }

  Future<ItemsDTO> dataSchoolPage(int userId, page, pageSize) async {
    return await itemService.itemsListOfUser(userId, page, pageSize);
  }

  Future<HomeDTO> dataHome(String role) async {
    HomeDTO homeConfig = await configService.homeLayout(role);
    if (homeConfig.featuresIcons == null) {
      homeConfig.featuresIcons = defaultHomeFeatures(role);
    }
    return homeConfig;
  }

  
}
