import 'package:anylearn/dto/pdp_dto.dart';
import 'package:anylearn/screens/home/hot_items.dart';
import 'package:anylearn/widgets/item_status_icon.dart';
import 'package:anylearn/widgets/price_box.dart';
import 'package:anylearn/widgets/rating.dart';
import 'package:anylearn/widgets/text2lines.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class PdpBody extends StatefulWidget {
  final PdpDTO data;

  const PdpBody({Key key, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PdpBody(data);
}

class _PdpBody extends State<PdpBody> {
  final PdpDTO data;

  _PdpBody(this.data);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double imageHeight = width - 30 - 50;
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 5.0, color: Colors.grey[100]))),
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(data.item.image, height: imageHeight, fit: BoxFit.cover),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text2Lines(text: data.item.title, fontSize: 16.0),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                RatingBox(score: data.item.rating),
                                data.item.rating > 0
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: InkWell(
                                          onTap: null,
                                          child: Text("XEM ĐÁNH GIÁ", style: TextStyle(color: Colors.blue)),
                                        ),
                                      )
                                    : Text("")
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.watch_later, color: Colors.black54, size: 14.0),
                                Text(" " +
                                    data.item.timeStart +
                                    " " +
                                    DateFormat('dd/MM').format(DateTime.parse(data.item.dateStart)))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.supervisor_account, color: Colors.black54, size: 14.0),
                                Text(" " + data.user.name)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: PriceBox(price: data.item.price, orgPrice: data.item.priceOrg, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ItemFavorStatusItem(
                            text: data.item.numCart.toString(), icon: Icons.add_shopping_cart, color: Colors.green),
                        ItemFavorStatusItem(text: data.item.numShare.toString(), icon: Icons.share, color: Colors.blue),
                        ItemFavorStatusItem(
                            text: data.item.numFavorite.toString(), icon: Icons.favorite, color: Colors.red),
                      ],
                    )
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  buttonMinWidth: (width - 30) / 4,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0), side: BorderSide(width: 1.0,color: Colors.red)),
                      onPressed: () {},
                      color: Colors.white,
                      child: Icon(Icons.favorite_border, color: Colors.red),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0), side: BorderSide(width: 1.0,color: Colors.green)),
                      onPressed: () {},
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Row(children: [Icon(Icons.add_shopping_cart), Text(" Đăng ký học")]),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0), side: BorderSide(width: 1.0,color: Colors.blue)),
                      color: Colors.white,
                      onPressed: () {},
                      child: Icon(Icons.share, color: Colors.blue),
                    ),
                  ],
                  // ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 5.0, color: Colors.grey[100]))),
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Thông tin khóa học", style: TextStyle(fontWeight: FontWeight.bold)),
                    ExpandableNotifier(
                      child: ScrollOnExpand(
                        child: Expandable(
                          collapsed: Column(
                            children: [
                              Text(
                                data.item.shortContent,
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              ExpandableButton(
                                child: Text(
                                  "XEM THÊM",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                          expanded: Column(children: [
                            Html(data: data.item.content, shrinkWrap: true,),
                            ExpandableButton(child: Text("THU GỌN", style: TextStyle(color: Colors.blue))),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ))),
        HotItems(hotItems: data.hotItems),
      ],
    );
  }
}
