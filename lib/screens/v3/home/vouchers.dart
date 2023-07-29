import 'package:flutter/material.dart';

import '../../../customs/custom_carousel.dart';
import '../../../dto/article_dto.dart';

class HomeVoucher extends StatelessWidget {
  late double width;
  final List<ArticleDTO> vouchers;

  HomeVoucher({Key? key, required this.vouchers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    width = screenW - 50;
    return Container(
      padding: EdgeInsets.only(bottom: 10, left: 10),
      height: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
            child: Row(
              children: [
                Expanded(
                  child: Text("Khuyến mãi từ anyLEARN", style: TextStyle(                          
                    fontWeight: FontWeight.bold,
                    fontSize: 18,  
                    height: 1.1,
                  )),
                ),
              ],
            ),
          ),
          CustomCarousel(
            items: vouchers,
            builderFunction: _itemSlider,
            height: 80,
            width: width,
            dividerIndent: 10,
          ),
        ],
      ),
    );
  }

  Widget _itemSlider(BuildContext context, dynamic item, double cardHeight) {
    // final screenW = MediaQuery.of(context).size.width;
    return Container(
      height: cardHeight,
      width: width,
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[100],
      ),
      child: ListTile(
        leading: Icon(Icons.discount_outlined, size: 40, color: Colors.green,),
        title: Text(item.title, style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.black87
        ),),
        subtitle: Text("Nhận khuyến mãi"),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
