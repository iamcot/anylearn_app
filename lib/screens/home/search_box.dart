import 'dart:async';

import 'package:easy_localization/easy_localization.dart';

import '../../dto/user_dto.dart';
import 'package:flutter/material.dart';

import '../../customs/custom_search_delegate.dart';

class SearchBox extends StatefulWidget {
  final user;

  SearchBox({key, this.user}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final searchController = TextEditingController();

  Timer? _debounce;
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        Text('title').tr();

    return Container(
      height: 120,
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text.rich(
              TextSpan(
                text:
                    "Tìm kiếm Trường học và Chuyên gia hàng đầu\n Khóa học Offline và Online".tr(),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
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
              cursorColor: Colors.white,
              readOnly: true,
              autofocus: false,
              controller: searchController,
              onTap: () {
                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                      screen: "",
                    ),
                    query: searchController.text);
              },
              onFieldSubmitted: (value) {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(screen: ""),
                  query: value,
                );
              },
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 2000), () async {
                  // await showSearch(
                  //   context: context,
                  //   delegate: CustomSearchDelegate(screen: ""),
                  //   query: value,
                  // );
                  print(value);
                });
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  hintText: "Hôm nay bạn muốn học gì ?".tr(),
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
