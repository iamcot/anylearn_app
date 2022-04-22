import '../customs/custom_search_delegate.dart';
import 'package:flutter/material.dart';

class SearchIcon extends StatelessWidget {
  final screen;

  const SearchIcon({required this.screen});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 0.0),
      child: IconButton(
        color: Colors.grey[500],
        icon: Icon(
          Icons.search,
          size: 24.0,
        ),
        onPressed: () {
          showSearch(context: context, delegate: CustomSearchDelegate(screen: screen));
        },
      ),
    );
  }
}
