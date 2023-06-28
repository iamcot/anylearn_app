import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/search/search_bloc.dart';
import '../dto/item_dto.dart';
import '../screens/v3/search/filter_widget.dart';
import 'custom_cached_image.dart';

class CustomSearchDelegate extends SearchDelegate {
  final screen;
  // final sugestion = tags ;
  CustomSearchDelegate({required this.screen});
// final SearchUserEvent  _tags = SearchEvent();
  @override
  String get searchFieldLabel {
    // if (screen == "school") {
    //   return "Tìm Trường Học...".tr();
    // } else if (screen == "teacher") {
    //   return "Tìm chuyên gia...".tr();
    // } else if (screen == "product") {
    //   return "Tìm sản phẩm...".tr();
    // }
    return "Tìm kiếm...".tr();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
      IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showResults(context);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // if (screen == "school" || screen == "teacher") {
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
    );
  }

  void searchOnFilterTap(BuildContext context, String _query) {
    query = _query;
    showResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
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
    );
  }
}
