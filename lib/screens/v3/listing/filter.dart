import 'package:flutter/material.dart';

class ListingFilter extends StatelessWidget implements PreferredSizeWidget {
  final Function callback;
  final List<Map<String, dynamic>> data = [
    {'filter': 'Hot', 'value': 'hot'},
    {'filter': 'New', 'value': 'date'},
    {'filter': 'Price', 'value': 'price'},
  ];
  static const double height = 55; 

  ListingFilter({Key? key, required this.callback}) : super(key: key);

  @override 
  Size get preferredSize => Size.fromHeight(height);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber.shade100,
      padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
      height: height,
      child: Row(
        children: [
          ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 10),
                child: FilledButton(
                  child: Text(
                    data[index]['filter'], 
                    style: TextStyle(
                      color: Colors.grey.shade800,            
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  ), 
                  onPressed: () => callback(context, data[index]['value']),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
