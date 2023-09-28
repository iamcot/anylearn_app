import 'package:anylearn/screens/v3/listing/card.dart';
import 'package:flutter/material.dart';

class ListingBody extends StatelessWidget {
  final List<dynamic> results;
  final ScrollController controller;
  final bool hasReached;

  const ListingBody({
    Key? key, 
    required this.results, 
    required this.controller, 
    required this.hasReached,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return results.isEmpty 
      ? Center(child: Text("Rất tiếc, không có thông tin bạn cần tìm."))
      : Container(
        child: ListView.builder(
          controller: controller,
          shrinkWrap: true,
          itemCount: results.length,
          itemBuilder: (context, index) {
            if(index == results.length - 1 && !hasReached) {
              return Center(child: CircularProgressIndicator());
            }
            return ListingCard(data: results[index]);
          },
        ),
        color: Colors.grey.shade100,
      );
  }
}