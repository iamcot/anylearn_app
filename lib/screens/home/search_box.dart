import 'package:flutter/material.dart';

import '../../customs/custom_search_delegate.dart';

class SearchBox extends StatelessWidget {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: TextFormField(
        controller: searchController,
        onTap: () {
          showSearch(context: context, delegate: CustomSearchDelegate(screen: ""), query: searchController.text);
        },
        onFieldSubmitted: (value) {
          showSearch(context: context, delegate: CustomSearchDelegate(screen: ""), query: value);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue[200], width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          hintText: "Hôm nay bạn muốn học gì ?",
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: Icon(Icons.search),
             
          // onPressed: () {
          //   showSearch(context: context, delegate: CustomSearchDelegate(screen: ""), query: searchController.text);
          // },
          // ),
        ),
      ),
    );
  }
}
