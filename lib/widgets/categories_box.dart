import 'package:flutter/material.dart';

import '../dto/category_dto.dart';

class CategoriesBox extends StatelessWidget {
  final List<CategoryDTO> categories;

  const CategoriesBox({Key key, this.categories}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: categories.length == 0
            ? []
            : List<Widget>.from(categories?.map((e) => Container(
                  margin: EdgeInsets.only(right: 5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.green[600])),
                  child: Text(e.title, style: TextStyle(color: Colors.green[600]),),
                ))).toList(),
      ),
    );
  }
}
