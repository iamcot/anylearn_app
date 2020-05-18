import 'package:anylearn/models/search_delegate.dart';
import 'package:flutter/material.dart';

class SearchIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 0.0),
      child: IconButton(
        icon: Icon(
          Icons.search,
          size: 32.0,
        ),
        onPressed: () {
          showSearch(context: context, delegate: CustomSearchDelegate());
        },
      ),
    );
  }
}
