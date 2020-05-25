import 'package:flutter/material.dart';

import '../../dto/items_dto.dart';
import '../../widgets/price_box.dart';
import '../../widgets/rating.dart';
import '../../widgets/sliver_banner.dart';
import '../../widgets/text2lines.dart';
import '../teacher/teacher_filter.dart';

class ItemsBody extends StatefulWidget {
  final ItemsDTO data;

  const ItemsBody({Key key, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemsBody(data);
}

class _ItemsBody extends State<ItemsBody> {
  final ItemsDTO data;

  _ItemsBody(this.data);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    return CustomScrollView(
      slivers: <Widget>[
        SliverBanner(
          banner: data.user.banner,
        ),
        TeacherFilter(),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: width,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 0.7,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.grey[100],
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      color: Colors.grey[100],
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("/pdp", arguments: data.items[index].id); //data.items[index].id.toString()
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: width * 3 / 4,
                            child: ClipRRect(
                              child: Image.network(
                                data.items[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text2Lines(
                              text: data.items[index].title,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RatingBox(
                      score: data.items[index].rating,
                      fontSize: 14.0,
                      alignment: "start",
                    ),
                    Row(children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: PriceBox(price: data.items[index].price, orgPrice: data.items[index].priceOrg),
                        ),
                      ),
                      Container(
                          child: IconButton(
                        icon: Icon(
                          Icons.add_shopping_cart,
                          color: Colors.blue,
                        ),
                        onPressed: null,
                      )),
                    ]),
                  ],
                ),
              );
            },
            childCount: data.items.length,
          ),
        ),
      ],
    );
  }
}
