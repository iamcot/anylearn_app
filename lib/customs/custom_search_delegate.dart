import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/search/search_blocs.dart';
import '../dto/item_dto.dart';
import '../dto/user_dto.dart';
import 'custom_cached_image.dart';

class CustomSearchDelegate extends SearchDelegate {
  final screen;
  // final sugestion = tags ;
  CustomSearchDelegate({required this.screen});
// final SearchUserEvent  _tags = SearchEvent();
  @override
  String get searchFieldLabel {
    if (screen == "school") {
      return "Tìm Trường Học...";
    } else if (screen == "teacher") {
      return "Tìm chuyên gia...";
    } else if (screen == "product") {
      return "Tìm sản phẩm...";
    }
    return "Tìm khóa học...";
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
    if (screen == "school" || screen == "teacher") {
      BlocProvider.of<SearchBloc>(context)
        ..add(SearchUserEvent(screen: screen, query: query));
    } else {
      BlocProvider.of<SearchBloc>(context)
        ..add(SearchItemEvent(screen: screen, query: query));
    }
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: BlocProvider.of<SearchBloc>(context),
      builder: (context, state) {
        if (state is SearchUserSuccessState) {
          final List<UserDTO> users = state.users;
          return users == null || users.length == 0
              ? Center(child: Text("Rất tiếc, không có thông tin bạn cần tìm."))
              : Container(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                              height: 50,
                              width: 50,
                              child: users[index].image == null
                                  ? Icon(Icons.broken_image)
                                  : CustomCachedImage(
                                      url: users[index].image,
                                    )),
                          title: Text(users[index].name),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.of(context).pushNamed("/items/$screen",
                                arguments: users[index].id);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: users.length),
                );
        }
        if (state is SearchItemSuccessState) {
          final List<ItemDTO> items = state.items;
          return items == null || items.length == 0
              ? Center(child: Text("Rất tiếc, không có thông tin bạn cần tìm."))
              : Container(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                              height: 50,
                              width: 50,
                              child: items[index].image == null
                                  ? Icon(Icons.broken_image)
                                  : CustomCachedImage(
                                      url: items[index].image,
                                    )),
                          title: Text(items[index].title),
                          subtitle: Text((items[index].authorType == "school"
                                  ? "Trung tâm: "
                                  : "Giảng viên: ") +
                              items[index].authorName),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed("/pdp", arguments: items[index].id);
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

  @override
  Widget buildSuggestions(BuildContext context) {

    if (query.isEmpty) {
      BlocProvider.of<SearchBloc>(context)..add(SearchTagsEvent());
    } else {
    if (screen == "school" || screen == "teacher") {
      BlocProvider.of<SearchBloc>(context)
        ..add(SearchUserEvent(screen: screen, query: query));
    } else {
      BlocProvider.of<SearchBloc>(context)
        ..add(SearchItemEvent(screen: screen, query: query));
    }
    }
    // return (screen == "school" || screen == "teacher")
    //     ? Text("")
        return BlocBuilder<SearchBloc, SearchState>(
            bloc: BlocProvider.of<SearchBloc>(context),
            builder: (context, state) {
              if (state is SearchTagsSuccessState) {
                return Container(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            "@${state.tags[index]}",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            query = "@${state.tags[index]}";
                            showResults(context);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: state.tags.length),
                );
              }
             if (state is SearchUserSuccessState) {
          final List<UserDTO> users = state.users;
          return users == null || users.length == 0
              ? Center(child: Text("Rất tiếc, không có thông tin bạn cần tìm."))
              : Container(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                              height: 50,
                              width: 50,
                              child: users[index].image == null
                                  ? Icon(Icons.broken_image)
                                  : CustomCachedImage(
                                      url: users[index].image,
                                    )),
                          title: Text(users[index].name),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.of(context).pushNamed("/items/$screen",
                                arguments: users[index].id);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: users.length),
                );
        }
         if (state is SearchItemSuccessState) {
          final List<ItemDTO> items = state.items;
          return items == null || items.length == 0
              ? Center(child: Text("Rất tiếc, không có thông tin bạn cần tìm."))
              : Container(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                              height: 50,
                              width: 50,
                              child: items[index].image == null
                                  ? Icon(Icons.broken_image)
                                  : CustomCachedImage(
                                      url: items[index].image,
                                    )),
                          title: Text(items[index].title),
                          subtitle: Text((items[index].authorType == "school"
                                  ? "Trung tâm: "
                                  : "Giảng viên: ") +
                              items[index].authorName),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed("/pdp", arguments: items[index].id);
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
