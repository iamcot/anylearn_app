import 'package:anylearn/blocs/listing/listing_bloc.dart';
import 'package:anylearn/blocs/search/search_bloc.dart';
import 'package:anylearn/dto/v3/home_dto.dart' show CategoryDTO;
import 'package:anylearn/screens/loading.dart';
import 'package:anylearn/screens/v3/listing/args.dart';
import 'package:anylearn/screens/v3/listing/filter.dart';
import 'package:anylearn/screens/v3/listing/screen.dart';
import 'package:anylearn/screens/v3/search/screen.dart';
import 'package:anylearn/themes/search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchDelegate extends SearchDelegate {
  // final sugestion = tags ;
  // final SearchUserEvent  _tags = SearchEvent();

  final String token;
  final String screen;

  final _hasFilter = ValueNotifier<bool>(false);
  ListingRouteArguments _listingArgs = ListingRouteArguments();

  CustomSearchDelegate({required this.screen, this.token = ''});

  @override
  String get searchFieldLabel {
     return "Hôm nay bạn muốn học gì?".tr();
    // if (screen == "school") {
    //   return "Tìm Trường Học...".tr();
    // } else if (screen == "teacher") {
    //   return "Tìm chuyên gia...".tr();
    // } else if (screen == "product") {
    //   return "Tìm sản phẩm...".tr();
    // }
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return searchTheme();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty) IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        }
      ),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () => showResults(context),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override 
  PreferredSizeWidget? buildBottom(BuildContext context) {
    return _hasFilter.value 
      ? ListingFilter(callback: listingOnFilterTap) 
      : null;
  }

  @override
  Widget buildResults(BuildContext context) {
    _hasFilter.value = true;
    _listingArgs.search = _listingArgs.category.isEmpty ? query : '';

    return ListingScreen(args: _listingArgs);
   
    /* if (screen == "school" || screen == "teacher") {
    //   BlocProvider.of<SearchBloc>(context)..add(SearchUserEvent(screen: screen, query: query));
    // } else {
    //   BlocProvider.of<SearchBloc>(context)..add(SearchItemEvent(screen: screen, query: query));
    // }
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: BlocProvider.of<SearchBloc>(context),
      builder: (context, state) {
        if (state is SearchItemSuccessState) {
          final List<ItemDTO> items = state.items;
          return items.length == 0
              ? Center(child: Text("Rất tiếc, không có thông tin bạn cần tìm.").tr())
              : Container(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                              height: 50,
                              width: 50,
                              child: items[index].image.isEmpty
                                  ? Icon(Icons.broken_image)
                                  : CustomCachedImage(
                                      url: items[index].image,
                                    )),
                          title: Text(items[index].title),
                          subtitle: Text("Đối tác: ".tr() + items[index].authorName),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.of(context).pushNamed("/pdp", arguments: items[index].id);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: items.length),
                );
        }
        return Center(child: CircularProgressIndicator());
      },
    );*/
  }

  @override
  void showResults(BuildContext context) {
    if (query.isEmpty && _listingArgs.category.isEmpty) return;
    super.showResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _listingArgs = ListingRouteArguments();
    _hasFilter.value = false;

    return BlocBuilder(
      bloc: BlocProvider.of<SearchBloc>(context)..add(SearchTagsEvent(token: token)),
      builder: (context, state) {
        if (state is SearchTagsSuccessState) {
          final data = state.suggestDTO;
          
          return query.isEmpty 
            ? SearchScreen(
                suggestions: data,
                tagCallback: searchOnFilterTap,
                categoryCallback: searchOnCategoryTap,
              ) 
            : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.lastSearch.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data.lastSearch[index], style: Theme.of(context).textTheme.bodyMedium),
                    leading: Icon(Icons.search, color: Colors.grey.shade700),
                    minLeadingWidth: 0,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    shape: Border(
                      bottom: BorderSide(
                        color:index == data.lastSearch.length - 1 
                          ? Colors.white
                          : Colors.black12
                      ),
                    ),
                    onTap: () => searchOnFilterTap(context, data.lastSearch[index]),
                  );
                }
              )
            );
        }

        return LoadingScreen();
      },
    );
    /*if (query.isEmpty) {
      BlocProvider.of<SearchBloc>(context)..add(SearchTagsEvent(screen: screen));
    } else {
      BlocProvider.of<SearchBloc>(context)..add(SearchItemEvent(screen: screen, query: query));
    }

    // return (screen == "school" || screen == "teacher")
    //     ? Text("") :
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: BlocProvider.of<SearchBloc>(context),
      builder: (context, state) {
        if (state is SearchFailState) {
          return Container(
            child: Text(state.error.toString()),
          );
        }
        if (state is SearchTagsSuccessState) {
          return SearchFilter(suggestion: state.suggestDTO, callback: searchOnFilterTap);
        }

        if (state is SearchItemSuccessState) {
          final List<ItemDTO> items = state.items;
          return items.length == 0
              ? Center(child: Text("Rất tiếc, không có thông tin bạn cần tìm.").tr())
              : Container(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                              height: 50,
                              width: 50,
                              child: items[index].image == ""
                                  ? Icon(Icons.broken_image)
                                  : CustomCachedImage(
                                      url: items[index].image,
                                    )),
                          title: Text(items[index].title),
                          subtitle: Text(
                              (items[index].authorType == "school" ? "Trung tâm: ".tr() : "Giảng viên: ".tr()) +
                                  items[index].authorName),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.of(context).pushNamed("/pdp", arguments: items[index].id);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: items.length),
                );
        }
        return CircularProgressIndicator();
      },
    );*/
  }

  void searchOnFilterTap(BuildContext context, String _query) {
    query = _query;
    showResults(context);
  }

  void searchOnCategoryTap(BuildContext context, CategoryDTO category) {
    query = category.title;
    _listingArgs.category = category.id.toString();
    showResults(context);
  }

  void listingOnFilterTap(BuildContext context, String filter) {
    //_listingArgs.sort = filter;
    BlocProvider.of<ListingBloc>(context).add(ListingFilterEvent(sort: filter));
    showResults(context);
  }

}
