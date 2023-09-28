import 'package:anylearn/customs/custom_search_delegate.dart';
import 'package:flutter/material.dart';

class ListingSearchBox extends StatelessWidget {
  final String? search;
  const ListingSearchBox({Key? key, this.search}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          hintText: search,
          hintStyle: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 18,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.grey.shade600,
            ),
            onPressed: () {},
          ),
        ),
        onTap: () => showSearch(
          context: context,
          delegate: CustomSearchDelegate(screen: ""),
        ),
      )
    );
  }
}