import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../blocs/pdp/pdp_blocs.dart';
import '../../customs/custom_cached_image.dart';
import '../../dto/login_callback.dart';
import '../../dto/pdp_dto.dart';
import '../../dto/user_dto.dart';
import '../../widgets/hot_items.dart';
import '../../widgets/item_status_icon.dart';
import '../../widgets/price_box.dart';
import '../../widgets/rating.dart';
import '../../widgets/text2lines.dart';
import '../item_rating.dart';
import 'course_confirm.dart';
import 'share_dialog.dart';

class PdpBody extends StatefulWidget {
  final PdpDTO data;
  final UserDTO user;
  final PdpBloc pdpBloc;

  const PdpBody({Key key, this.data, this.user, this.pdpBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PdpBody();
}

class _PdpBody extends State<PdpBody> {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: imageHeight,
                  child: widget.data.item.image != null
                      ? CustomCachedImage(url: widget.data.item.image)
                      : Icon(Icons.broken_image),
                ),
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
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(builder: (BuildContext context) {
                                              return ItemRatingScreen(itemId: widget.data.item.id);
                                            }));
                                          },
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
                                Icon(Icons.calendar_today, color: Colors.black54, size: 14.0),
                                Text(" Khai giảng: " +
                                    widget.data.item.timeStart +
                                    " " +
                                    DateFormat('dd/MM').format(DateTime.parse(widget.data.item.dateStart))),
                                widget.data.numSchedule > 1
                                    ? Text(" (${widget.data.numSchedule} buổi học)")
                                    : SizedBox(height: 1)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.supervisor_account, color: Colors.black54, size: 14.0),
                                Text(widget.data.author.role == 'school' ? " Trường: " : " Giảng viên: "),
                                Text.rich(
                                  TextSpan(
                                      text: widget.data.author.name,
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context).pushNamed("/items/" + widget.data.author.role,
                                              arguments: widget.data.author.id);
                                        }),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: (Platform.isIOS && !widget.data.enableIosTrans)
                                ? SizedBox(height: 0)
                                : PriceBox(
                                    price: widget.data.item.price, orgPrice: widget.data.item.priceOrg, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        (Platform.isIOS && widget.data.enableIosTrans) &&
                                (widget.data.item.numCart != null && widget.data.item.numCart > 0)
                            ? ItemFavorStatusItem(
                                text: widget.data.item.numCart.toString(),
                                icon: Icons.add_shopping_cart,
                                color: Colors.green)
                            : SizedBox(height: 0),
                        widget.data.item.numShare != null
                            ? ItemFavorStatusItem(
                                text: widget.data.item.numShare.toString(), icon: Icons.share, color: Colors.blue)
                            : SizedBox(height: 0),
                        widget.data.item.numFavorite != null && widget.data.item.numFavorite > 0
                            ? ItemFavorStatusItem(
                                text: widget.data.item.numFavorite.toString(), icon: Icons.favorite, color: Colors.red)
                            : SizedBox(height: 0),
                      ],
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    (Platform.isIOS && !widget.data.enableIosTrans)
                        ? SizedBox(
                            height: 0,
                          )
                        : Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(width: 1.0, color: Colors.green)),
                              onPressed: () {
                                widget.user != null
                                    ? showDialog(
                                        context: context,
                                        builder: (context) => (!widget.data.item.nolimitTime &&
                                                DateTime.now().isAfter(DateTime.parse(
                                                    widget.data.item.dateStart + " " + widget.data.item.timeStart)))
                                            ? AlertDialog(
                                                content: Container(child: Text("Đã quá hạn đăng ký khóa học này.")),
                                                actions: [
                                                  RaisedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text("ĐÃ HIỂU"),
                                                    color: Colors.blue,
                                                  ),
                                                ],
                                              )
                                            : CourseConfirm(
                                                pdpBloc: widget.pdpBloc,
                                                user: widget.user,
                                                pdpDTO: widget.data,
                                              ),
                                      )
                                    : Navigator.of(context).pushNamed('/login',
                                        arguments: LoginCallback(routeName: "/pdp", routeArgs: widget.data.item.id));
                              },
                              color: Colors.green,
                              textColor: Colors.white,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Icon(Icons.add_shopping_cart), Text(" Đăng ký học")]),
                            ),
                          ),
                    BlocListener(
                      bloc: widget.pdpBloc,
                      listener: (BuildContext context, state) {
                        if (state is PdpFavoriteTouchSuccessState) {
                          toast(
                              state.isFav ? "Đã đánh dấu ưa thích khóa học này." : "Đã bỏ đánh dấu ưa thích khóa học.");
                          widget.data.isFavorite = state.isFav;
                        }
                      },
                      child: BlocBuilder<PdpBloc, PdpState>(
                        bloc: BlocProvider.of<PdpBloc>(context),
                        builder: (context, state) {
                          return (Platform.isIOS && !widget.data.enableIosTrans)
                              ? Expanded(
                                  child: RaisedButton(
                                  onPressed: () {
                                    if (widget.user != null) {
                                      BlocProvider.of<PdpBloc>(context)
                                        ..add(PdpFavoriteTouchEvent(
                                            itemId: widget.data.item.id, token: widget.user.token));
                                    } else {
                                      Navigator.of(context).pushNamed('/login',
                                          arguments: LoginCallback(routeName: "/pdp", routeArgs: widget.data.item.id));
                                    }
                                  },
                                  color: widget.data.isFavorite == true ? Colors.red : Colors.white,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Icon(
                                      widget.data.isFavorite == true ? Icons.favorite : Icons.favorite_border,
                                      color: widget.data.isFavorite != true ? Colors.red : Colors.white,
                                    ),
                                    Text(
                                      " Quan tâm",
                                      style:
                                          TextStyle(color: widget.data.isFavorite != true ? Colors.red : Colors.white),
                                    )
                                  ]),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(width: 1.0, color: Colors.red)),
                                ))
                              : IconButton(
                                  onPressed: () {
                                    if (widget.user != null) {
                                      BlocProvider.of<PdpBloc>(context)
                                        ..add(PdpFavoriteTouchEvent(
                                            itemId: widget.data.item.id, token: widget.user.token));
                                    } else {
                                      Navigator.of(context).pushNamed('/login',
                                          arguments: LoginCallback(routeName: "/pdp", routeArgs: widget.data.item.id));
                                    }
                                  },
                                  icon: Icon(widget.data.isFavorite == true ? Icons.favorite : Icons.favorite_border,
                                      color: Colors.red),
                                );
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      color: Colors.blue,
                      onPressed: () {
                        widget.user != null
                            ? showDialog(
                                context: context,
                                builder: (context) => PdpShareDialog(
                                  itemId: widget.data.item.id,
                                  user: widget.user,
                                  pdpBloc: widget.pdpBloc,
                                ),
                              )
                            : Navigator.of(context).pushNamed('/login',
                                arguments: LoginCallback(routeName: "/pdp", routeArgs: widget.data.item.id));
                      },
                    ),
                  ],
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
                                widget.data.item.shortContent ?? "",
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
                              data: widget.data.item.content ?? "",
                              shrinkWrap: true,
                            ),
                            ExpandableButton(child: Text("THU GỌN", style: TextStyle(color: Colors.blue))),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ))),
        SliverToBoxAdapter(child: HotItems(hotItems: [widget.data.hotItems])),
      ],
    );
  }
}
