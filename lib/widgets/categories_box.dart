import 'package:flutter/material.dart';

import '../dto/category_dto.dart';

class CategoriesBox extends StatelessWidget {
  final List<CategoryDTO> categories;

  const CategoriesBox({required this.categories});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: categories.length == 0
            ? []
            : List<Widget>.from(categories.map((e) => Container(
                  margin: EdgeInsets.only(right: 5, bottom: 5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: (Colors.green[600])!)),
                  child: Text(e.title, style: TextStyle(color: Colors.green[600]),),
                ))).toList(),
      ),
    );
  }
}
