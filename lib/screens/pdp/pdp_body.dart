import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import '../../blocs/pdp/pdp_blocs.dart';
import '../../dto/pdp_dto.dart';
import '../../dto/user_dto.dart';
import '../../widgets/item_status_icon.dart';
import '../../widgets/price_box.dart';
import '../../widgets/rating.dart';
import '../../widgets/text2lines.dart';
import '../home/hot_items.dart';
import 'course_confirm.dart';
import 'share_dialog.dart';

class PdpBody extends StatefulWidget {
  final PdpDTO data;
  final UserDTO user;

  const PdpBody({Key key, this.data, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PdpBody();
}

class _PdpBody extends State<PdpBody> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double imageHeight = width - 30 - 50;
    bool isFavorite = widget.data.isFavorite;
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
                widget.data.item.image != null ? Image.network(widget.data.item.image, height: imageHeight, fit: BoxFit.cover) : Icon(Icons.broken_image),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text2Lines(text: widget.data.item.title, fontSize: 16.0),
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
                                RatingBox(score: widget.data.item.rating),
                                widget.data.item.rating != null
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
                                    widget.data.item.timeStart +
                                    " " +
                                    DateFormat('dd/MM').format(DateTime.parse(widget.data.item.dateStart)))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.supervisor_account, color: Colors.black54, size: 14.0),
                                Text(" " + widget.data.author.name)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: PriceBox(
                                price: widget.data.item.price, orgPrice: widget.data.item.priceOrg, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ItemFavorStatusItem(
                            text: widget.data.item.numCart.toString(),
                            icon: Icons.add_shopping_cart,
                            color: Colors.green),
                        ItemFavorStatusItem(
                            text: widget.data.item.numShare.toString(), icon: Icons.share, color: Colors.blue),
                        ItemFavorStatusItem(
                            text: widget.data.item.numFavorite.toString(), icon: Icons.favorite, color: Colors.red),
                      ],
                    )
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  buttonMinWidth: (width - 30) / 4,
                  children: [
                    BlocBuilder<PdpBloc, PdpState>(
                      bloc: BlocProvider.of<PdpBloc>(context),
                      builder: (context, state) {
                        if (state is PdpFavoriteAddState) {
                          isFavorite = state.data.isFavorite;
                        }
                        if (state is PdpFavoriteRemoveState) {
                          isFavorite = state.data.isFavorite;
                        }
                        return RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(width: 1.0, color: Colors.red)),
                          color: Colors.white,
                          onPressed: () {
                            if (widget.user != null) {
                              BlocProvider.of<PdpBloc>(context)
                                ..add(isFavorite == true
                                    ? PdpFavoriteRemoveEvent(itemId: widget.data.item.id, userId: widget.user.id)
                                    : PdpFavoriteAddEvent(itemId: widget.data.item.id, userId: widget.user.id));
                            } else {
                              Navigator.of(context).pushNamed('/login');
                            }
                          },
                          child: Icon(isFavorite == true ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                        );
                      },
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0), side: BorderSide(width: 1.0, color: Colors.green)),
                      onPressed: () {
                        widget.user != null
                            ? showDialog(
                                context: context,
                                builder: (context) => CourseConfirm(user: widget.user, pdpDTO: widget.data,),
                              )
                            : Navigator.of(context).pushNamed('/login');
                      },
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Row(children: [Icon(Icons.add_shopping_cart), Text(" Đăng ký học")]),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0), side: BorderSide(width: 1.0, color: Colors.blue)),
                      color: Colors.white,
                      onPressed: () {
                        widget.user != null
                            ? showDialog(
                                context: context,
                                builder: (context) => PdpShareDialog(itemId: widget.data.item.id),
                              )
                            : Navigator.of(context).pushNamed('/login');
                      },
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
                                widget.data.item.shortContent,
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
                            Html(
                              data: widget.data.item.content,
                              shrinkWrap: true,
                            ),
                            ExpandableButton(child: Text("THU GỌN", style: TextStyle(color: Colors.blue))),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ))),
        HotItems(hotItems: [widget.data.hotItems]),
      ],
    );
  }
}
