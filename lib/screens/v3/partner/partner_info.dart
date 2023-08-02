import 'package:anylearn/dto/user_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PartnerInfo extends StatelessWidget {
  final UserDTO partner;
  final double sumRating;
  final int sumReviews;
  const PartnerInfo({Key? key, required this.partner, required this.sumRating, required this.sumReviews}) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = width / 2;
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Stack(children: [
        CachedNetworkImage(imageUrl: partner.image, width: width, height: height, fit: BoxFit.cover),
        Container(
          margin: EdgeInsets.only(left: 20, top: height - 50, right: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 1
              ),
            borderRadius: BorderRadius.circular(30)
    
            ),
          child: Row(
            children: [
              Expanded(
                child: Column(children: [
                  Container(
                    child: Text(
                      partner.name, 
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(  
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(                 
                      children: [
                        Text(
                          'Đánh giá: $sumRating',  
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        Text(
                          ' ($sumReviews lượt nhận xét)',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            partner.introduce, 
                            maxLines: 8,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Text(
                          'Mã KM: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                       Container(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            'ADdfaf12iohnhA', 
                            style:  TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                  ),*/
                ]),
              ),
            ],
          ),
        )],
      ),
    );
  }
}