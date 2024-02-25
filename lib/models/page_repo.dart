import 'dart:io';

import 'package:anylearn/dto/v3/calendar_dto.dart';
import 'package:anylearn/dto/v3/listing_dto.dart';
import 'package:anylearn/dto/v3/partner_dto.dart';
import 'package:anylearn/dto/v3/registered_item_dto.dart';
import 'package:anylearn/dto/v3/schedule_dto.dart';
import 'package:anylearn/dto/v3/study_dto.dart';
import 'package:anylearn/dto/v3/subtype_dto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../dto/article_dto.dart';
import '../dto/ask_paging_dto.dart';
import '../dto/ask_thread_dto.dart';
import '../dto/const.dart';
import '../dto/doc_dto.dart';
import '../dto/event_dto.dart';
import '../dto/item_dto.dart';
import '../dto/items_dto.dart';
import '../dto/pdp_dto.dart';
import '../dto/quote_dto.dart';
import '../dto/user_dto.dart';
import '../dto/users_dto.dart';
import '../dto/v3/home_dto.dart';
import '../dto/v3/search_suggest_dto.dart';
import '../services/ask_service.dart';
import '../services/config_services.dart';
import '../services/item_services.dart';
import '../services/quote_service.dart';
import '../services/user_services.dart';

class PageRepository {
  late UserService userService;
  late QuoteService quoteService;
  late ItemService itemService;
  late ConfigServices configService;
  late AskService askService;
  // TransactionService transactionService;
  final config;
  final httpClient = http.Client();

  PageRepository({this.config}) {
    quoteService = QuoteService(httpClient: this.httpClient);
    userService = UserService(config: config, httpClient: this.httpClient);
    configService = ConfigServices(config: config, httpClient: this.httpClient);
    itemService = ItemService(config: config, httpClient: this.httpClient);
    askService = AskService(config: config, httpClient: this.httpClient);
    // transactionService = TransactionService(config: config, httpClient: httpClient);
  }

  Future<ListingDTO> dataListing(String query) async {
    return await configService.dataListing(query);
  }

  Future<PartnerDTO> dataPartner(int partnerId) async {
    return await configService.dataPartner(partnerId);
  } 

  Future<PdpDTO> dataPDP(int itemId, String token) async {
    return await itemService.getPDPData(itemId, token);
  }

  Future<bool> touchFav(int itemId, String token) async {
    return await itemService.touchFav(itemId, token);
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

  Future<List<CategoryPagingDTO>> category(int catId, page, pageSize) async {
    return await configService.category(catId, page, pageSize);
  }

  Future<HomeV3DTO> dataHome(String token, String role, int userId) async {
    HomeV3DTO homeConfig = await configService.homeV3Layout(token, role);
    return homeConfig;
  }

  Future<SubtypeDTO> dataSubtype(String category, String token) async {
    SubtypeDTO data = await configService.subtypeData(category, token);
    return data;
  }

  Future<bool> imageValidation(String url) async {
    return await configService.imageValidation(url);
  }

  Future<QuoteDTO> getQuote(String url) async {
    return await quoteService.getQuote(url);
  }

  Future<Map<DateTime, List<EventDTO>>> monthEvent(DateTime month) async {
    return configService.monthEvent(month);
  }

  Future<DocDTO> guide(String key) async {
    return configService.doc(key);
  }

  Future<bool> saveFeedback(String token, String content, File file) async {
    return await configService.saveFeedback(token, content, file);
  }

  Future<List<UserDTO>> searchUser(String screen, String query) async {
    return await configService.searchUser(screen, query);
  }

  Future<List<ItemDTO>> searchItem(String screen, String query) async {
    return await configService.searchItem(screen, query);
  }

  Future<List<UserDTO>> allFriends(String token) async {
    return await userService.allFriends(token);
  }

  Future<bool> shareFriends(String token, int id, List<int> friends, bool isALL) async {
    return await userService.shareFriends(token, id, friends, isALL);
  }

  Future<ArticleHomeDTO> articleIndexPage() async {
    return await configService.articleIndexPage();
  }

  Future<ArticlePagingDTO> articleTypePage(String type, int page) async {
    return await configService.articleTypePage(type, page);
  }

  Future<ArticleDTO> article(int id) async {
    return await configService.article(id);
  }

  Future<int> getPopupVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int popupVersion = prefs.getInt('home_popup') ?? 0;
    print("popupVersion: $popupVersion");
    return popupVersion;
  }

  Future<void> savePopupVersion(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('home_popup', value);
  }

  Future<AskPagingDTO> getAskList() async {
    return await askService.getList();
  }

  Future<AskThreadDTO> getAskThread(int askId, String token) async {
    return await askService.getThread(askId, token);
  }

  Future<bool> createAsk(int askId, String title, String content, UserDTO userDTO, String type) async {
    return await askService.create(askId, title, content, userDTO, type);
  }

  Future<bool> askSelectAnswer(int askId, String token) async {
    return await askService.selectAnswer(askId, token);
  }

  Future<bool> askVote(int askId, String type, String token) async {
    return await askService.vote(askId, type, token);
  }

  Future<List<String>> searchTags() async {
    return await configService.searchTags();
  }
  
  Future<SearchSuggestDTO> searchSuggestion(String token) async {
    return await configService.searchSuggestion(token);
  }

  Future<List<ItemDTO>> suggestFromKeyword(String screen, String query) async {
    return await configService.searchItem(screen, query);
  }

  Future<StudyDTO> dataStudy(UserDTO account, String token) async {
    return await configService.dataStudy(account, token);
  }

  Future<CalendarDTO> dataSchedule(String token, String date) async {
    return await configService.dataSchedule(token, date);
  }

  Future<RegisteredItemDTO> dataRegisteredCourse(String token, int orderItemID) async {
    return await configService.dataRegisteredCourse(token, orderItemID);
  }
}
