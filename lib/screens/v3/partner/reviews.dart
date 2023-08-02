import 'package:anylearn/customs/custom_carousel.dart';
import 'package:anylearn/dto/v3/partner_dto.dart';
import 'package:flutter/material.dart';

class Reviews extends StatelessWidget {
  final List<ReviewDTO> reviews;

  const Reviews({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return reviews.isEmpty 
      ? Container()
      : Container(
        color: Colors.grey.shade100,
        margin: EdgeInsets.only(top: 20, bottom: 10),
        padding: EdgeInsets.all(20),
        child: CustomCarousel(items: reviews, builderFunction: _itemBuilder, height: 160)
      );
  }

  Widget _itemBuilder(BuildContext context, dynamic item, double height) {
    final width = MediaQuery.of(context).size.width;
    return Container(  
      width: width,
      child: Column(
        children: [
          Row(
            children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Row(children: [
                          Text(
                            item.name, 
                            style: TextStyle(fontSize: 16)
                          )
                        ])
                      ]
                    ),
                  ),
                ),
              ],
          ),
          Row(
            children: [
              SizedBox(
                width: width - 40,
                height: height - 35,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item.content,
                    maxLines: 4,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )  
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}