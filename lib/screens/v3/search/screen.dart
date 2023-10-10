
import 'package:anylearn/dto/v3/search_suggest_dto.dart';
import 'package:anylearn/screens/v3/search/categories.dart';
import 'package:anylearn/screens/v3/search/last_search.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final SearchSuggestDTO suggestions;
  final Function tagCallback;
  final Function categoryCallback;

  const SearchScreen({
    Key? key, 
    required this.suggestions, 
    required this.tagCallback,
    required this.categoryCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: ListView(
        children: [
          if (suggestions.lastSearch.isNotEmpty) LastSearch(
            data: suggestions.lastSearch, 
            callback: tagCallback
          ),
          if (suggestions.categories.isNotEmpty) SearchCategories(
            data: suggestions.categories, 
            callback: categoryCallback
          ),
        ]
      ),
    );
  }
}
