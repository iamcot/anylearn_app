import 'package:anylearn/dto/doc_dto.dart';
import 'package:anylearn/dto/event_dto.dart';
import 'package:anylearn/dto/quote_dto.dart';
import 'package:anylearn/services/transaction_service.dart';
import 'package:http/http.dart' as http;

import '../dto/const.dart';
import '../dto/home_dto.dart';
import '../dto/items_dto.dart';
import '../dto/pdp_dto.dart';
import '../dto/users_dto.dart';
import '../services/config_services.dart';
import '../services/item_services.dart';
import '../services/quote_service.dart';
import '../services/user_services.dart';
import 'default_feature_data.dart';

class PageRepository {
  UserService userService;
  QuoteService quoteService;
  ItemService itemService;
  ConfigServices configService;
  // TransactionService transactionService;
  final config;
  final httpClient = http.Client();

  PageRepository({this.config}) {
    quoteService = QuoteService(httpClient: this.httpClient);
    userService = UserService(config: config, httpClient: this.httpClient);
    configService = ConfigServices(config: config, httpClient: this.httpClient);
    itemService = ItemService(config: config, httpClient: this.httpClient);
    // transactionService = TransactionService(config: config, httpClient: httpClient);
  }

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

  Future<HomeDTO> dataHome(String role, int userId) async {
    HomeDTO homeConfig = await configService.homeLayout(role);
    if (homeConfig.featuresIcons == null) {
      homeConfig.featuresIcons = defaultHomeFeatures(role, userId);
    }
    return homeConfig;
  }

  Future<QuoteDTO> getQuote() async {
    return await quoteService.getQuote();
  }

  Future<Map<DateTime, List<EventDTO>>> monthEvent(DateTime month) async {
    return configService.monthEvent(month);
  }

  Future<DocDTO> guide(String key) async {
    return configService.doc(key);
  }
}
