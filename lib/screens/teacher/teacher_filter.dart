import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TeacherFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeacherFilter();
}

class _TeacherFilter extends State<TeacherFilter> {
  String dropdownValue = "popular";
  Map<String, String> options = {
    // 'nameaz': 'Theo tên A-Z',
    // 'nameza': 'Theo tên Z-A',
    // 'course': 'Theo Số lượng Khóa học',
    'popular': 'Theo mức độ quan tâm',
  };

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: (Colors.grey[200])!))),
        // padding: EdgeInsets.only(left: 15.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(Icons.keyboard_arrow_down),
          iconSize: 24,
          elevation: 16,
          isExpanded: true,
          selectedItemBuilder: (BuildContext context) => _buildSelected(context),
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
          underline: Container(
            color: Colors.transparent,
          ),
          onChanged: (newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: _buildList(options),
        ),
      ),
    );
  }

  List<Widget> _buildSelected(BuildContext context) {
        Text('title').tr();

    List<Widget> list = [];
    options.forEach((key, title) {
      list.add(Container(
          margin: EdgeInsets.all(0.0),
          padding: EdgeInsets.all(0.0),
          child: Row(
            children: <Widget>[
              Text("Sắp xếp: "),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
              ),
            ],
          )));
    });
    return list;
  }

  List<DropdownMenuItem<String>> _buildList(options) {
    List<DropdownMenuItem<String>> list = [];
    options.forEach((key, title) {
      list.add(
        DropdownMenuItem<String>(
          value: key,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: dropdownValue == key ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      );
    });
    return list;
  }
}
