import 'package:anylearn/dto/pdp_dto.dart';
import 'package:anylearn/widgets/price_box.dart';
import 'package:anylearn/widgets/rating.dart';
import 'package:anylearn/widgets/text2lines.dart';
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
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              width: 5.0,
              color: Colors.grey[100],
            ))),
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  data.item.image,
                  height: width - 30 - 50,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text2Lines(
                    text: data.item.title,
                    fontSize: 16.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.watch_later,
                        size: 14.0,
                      ),
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
                      Icon(
                        Icons.supervisor_account,
                        size: 14.0,
                      ),
                      Text(" " + data.user.name)
                    ],
                  ),
                ),
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
                                child: Text(
                                  "XEM NHẬN XÉT",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            )
                          : Text("")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: PriceBox(
                          price: data.item.price,
                          orgPrice: data.item.priceOrg,
                          fontSize: 18.0,
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Colors.blue,
                          ),
                          onPressed: null),
                      IconButton(
                        icon: Icon(Icons.favorite_border, color: Colors.red),
                        onPressed: null,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: new RaisedButton(
                    onPressed: () {},
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text("Đăng ký khóa học"),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thông tin khóa học",
                  style: TextStyle(
                      // color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Html(
                    data: data.item.content,
                  ),
                  // Text(
                  //   data.item.content,
                  //   style: TextStyle(),
                  // ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
