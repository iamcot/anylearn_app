import '../../dto/user_dto.dart';
import 'package:flutter/material.dart';

import '../../customs/custom_search_delegate.dart';

class SearchBox extends StatelessWidget {
  final searchController = TextEditingController();
  final UserDTO user;

  SearchBox({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text.rich(TextSpan(
                text: "Nền tảng tìm kiếm Trường học và Chuyên gia hàng đầu, Khóa học Offline và Online",
              ), textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600]),),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 20,
                ),
              ],
            ),
            margin: const EdgeInsets.only(right: 20.0, left: 20.0),
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
                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  hintText: "Hôm nay bạn muốn học gì ?",
                  hintStyle: TextStyle(color: Colors.grey),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.green[600],
                  )

                  // onPressed: () {
                  //   showSearch(context: context, delegate: CustomSearchDelegate(screen: ""), query: searchController.text);
                  // },
                  // ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
