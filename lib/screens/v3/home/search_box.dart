import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../customs/custom_search_delegate.dart';

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
    return TextFormField(
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
          print(value);
        });
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey, width: 0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey, width: 0),
          ),
          hintText: "Hôm nay bạn muốn học gì?".tr(),
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
    );
  }
}
