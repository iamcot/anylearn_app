import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {

  @override
  String get searchFieldLabel => "Tìm khóa học, sản phẩm";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(child: Text("Rất tiếc! không có thông tin liên quan từ khóa bạn đang tìm kiếm.")),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
