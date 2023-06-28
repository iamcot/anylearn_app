import 'package:anylearn/dto/v3/search_suggest_dto.dart';
import 'package:flutter/material.dart';
import 'package:simple_tags/simple_tags.dart';

class SearchFilter extends StatefulWidget {
  final SearchSuggestDTO suggestion;
  final Function callback;

  const SearchFilter({Key? key, required this.suggestion, required this.callback}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SearchFilter();
}

class _SearchFilter extends State<SearchFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tìm kiếm gần đây",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: SimpleTags(
                content: widget.suggestion.lastSearch,
                wrapSpacing: 8,
                wrapRunSpacing: 8,
                onTagPress: (tag) {
                  widget.callback(context, tag);
                },
                tagContainerPadding: EdgeInsets.all(6),
                tagTextStyle: TextStyle(color: Colors.blue),
                // tagIcon: Icon(Icons.search, size: 12),
                tagContainerDecoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(139, 139, 142, 0.16),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(1.75, 3.5), // c
                    )
                  ],
                ),
              ),
            ),
            // Text(
            //   "Học phí",
            //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            // ),
            // Container(
            //   padding: EdgeInsets.only(top: 15, bottom: 15),
            // ),
            // Text(
            //   "Địa điểm",
            //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            // ),
            // Container(
            //   padding: EdgeInsets.only(top: 15, bottom: 15),
            // ),
            Text(
              "Lĩnh vực",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            Container(
              // padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                  children: widget.suggestion.categories
                      .map((cat) => ListTile(
                            title: Text(cat.title),
                            trailing: Icon(Icons.chevron_right_outlined),
                            contentPadding: EdgeInsets.all(0),
                          ))
                      .toList()),
            ),
          ],
        ));
  }
}
