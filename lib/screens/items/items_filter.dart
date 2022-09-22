import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ItemsFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemsFilter();
}

class _ItemsFilter extends State<ItemsFilter> {
  
  String dropdownValue = "newest";
  Map<String, String> options = {
    
    // 'nameaz': 'Theo tên A-Z',
    // 'nameza': 'Theo tên Z-A',
    // 'course': 'Theo Số lượng Khóa học',
    'newest': 'Mới nhất',
  };

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
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
          Divider(
            height: 0.0,
            thickness: 1.0,
            color: Colors.black12,
          ),
        ],
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
