import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../blocs/pdp/pdp_blocs.dart';
import '../../customs/custom_cached_image.dart';
import '../../dto/home_dto.dart';
import '../../dto/login_callback.dart';
import '../../dto/pdp_dto.dart';
import '../../main.dart';
import '../../widgets/categories_box.dart';
import '../../widgets/item_status_icon.dart';
import '../../widgets/price_box.dart';
import '../../widgets/rating.dart';
import '../../widgets/text2lines.dart';
import '../home/home_classes.dart';
import '../item_rating.dart';
import '../webview.dart';
import 'share_dialog.dart';

class PdpBody extends StatefulWidget {
  final PdpDTO data;
  final PdpBloc pdpBloc;

  const PdpBody({key, required this.data, required this.pdpBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PdpBody();
}

class _PdpBody extends State<PdpBody> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double imageHeight = width - 30 - 50;
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 5.0, color: (Colors.grey[200])!))),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: imageHeight,
                    child: widget.data.item.image != null
                        ? CustomCachedImage(
                            url: widget.data.item.image,
                            borderRadius: 10.0,
                          )
                        : Icon(Icons.broken_image),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text2Lines(
                      text: widget.data.item.title,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.supervisor_account, color: Colors.black54, size: 14.0),
                        Text.rich(
                          TextSpan(
                              text: widget.data.author.name,
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context)
                                      .pushNamed("/items/" + widget.data.author.role, arguments: widget.data.author.id);
                                }),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CategoriesBox(categories: widget.data.categories),
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
                                            child: Text("XEM ĐÁNH GIÁ", style: TextStyle(color: Colors.blue)).tr(),
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
                                  Text(" Khai giảng: ".tr() +
                                          widget.data.item.timeStart +
                                          " " +
                                          DateFormat('dd/MM').format(DateTime.parse(widget.data.item.dateStart)))
                                      .tr(),
                                  widget.data.numSchedule > 1
                                      ? Text(" (${widget.data.numSchedule} buổi học)".tr())
                                      : SizedBox(height: 1)
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: (Platform.isIOS && !widget.data.enableIosTrans)
                                  ? SizedBox(height: 0)
                                  : PriceBox(
                                      price: widget.data.item.price,
                                      orgPrice: widget.data.item.priceOrg,
                                      fontSize: 18.0,
                                      showOrgPrice: true,
                                    ),
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
                                  text: widget.data.item.numFavorite.toString(),
                                  icon: Icons.favorite,
                                  color: Colors.red)
                              : SizedBox(height: 0),
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: <Widget>[
                        (Platform.isIOS && !widget.data.enableIosTrans)
                            ? SizedBox(
                                height: 0,
                              )
                            : Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>((Colors.green[600])!),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ))),
                                  onPressed: () {
                                    _add2Cart(context, user.token, widget.data.item.id);
                                  },
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [Icon(Icons.app_registration), Text("ĐĂNG KÝ").tr()]),
                                ),
                              ),
                        BlocListener(
                          bloc: widget.pdpBloc,
                          listener: (BuildContext context, state) {
                            if (state is PdpFavoriteTouchSuccessState) {
                              toast(state.isFav
                                  ? "Đã đánh dấu ưa thích khóa học này.".tr()
                                  : "Đã bỏ đánh dấu ưa thích khóa học.".tr());
                              widget.data.isFavorite = state.isFav;
                            }
                          },
                          child: BlocBuilder<PdpBloc, PdpState>(
                            bloc: BlocProvider.of<PdpBloc>(context),
                            builder: (context, state) {
                              return (Platform.isIOS && !widget.data.enableIosTrans)
                                  ? Expanded(
                                      child: ElevatedButton(
                                      onPressed: () {
                                        if (user.token != "") {
                                          BlocProvider.of<PdpBloc>(context)
                                            ..add(
                                                PdpFavoriteTouchEvent(itemId: widget.data.item.id, token: user.token));
                                        } else {
                                          Navigator.of(context).pushNamed('/login',
                                              arguments:
                                                  LoginCallback(routeName: "/pdp", routeArgs: widget.data.item.id));
                                        }
                                      },
                                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                        Icon(
                                          widget.data.isFavorite == true ? Icons.favorite : Icons.favorite_border,
                                          color: widget.data.isFavorite != true ? Colors.red : Colors.white,
                                        ),
                                        Text(
                                          " Quan tâm",
                                          style: TextStyle(
                                              color: widget.data.isFavorite != true ? Colors.red : Colors.white),
                                        ).tr()
                                      ]),
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                            widget.data.isFavorite == true ? Colors.red : Colors.white,
                                          ),
                                          shape:
                                              MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18),
                                          ))),
                                    ))
                                  : IconButton(
                                      onPressed: () {
                                        if (user.token != "") {
                                          BlocProvider.of<PdpBloc>(context)
                                            ..add(
                                                PdpFavoriteTouchEvent(itemId: widget.data.item.id, token: user.token));
                                        } else {
                                          Navigator.of(context).pushNamed('/login',
                                              arguments:
                                                  LoginCallback(routeName: "/pdp", routeArgs: widget.data.item.id));
                                        }
                                      },
                                      icon: Icon(
                                          widget.data.isFavorite == true ? Icons.favorite : Icons.favorite_border,
                                          color: Colors.red),
                                    );
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.share),
                          color: Colors.blue,
                          onPressed: () {
                            user.token != ""
                                ? showDialog(
                                    context: context,
                                    builder: (context) => PdpShareDialog(
                                      item: widget.data.item,
                                      user: user,
                                      pdpBloc: widget.pdpBloc,
                                    ),
                                  )
                                : Navigator.of(context).pushNamed('/login',
                                    arguments: LoginCallback(routeName: "/pdp", routeArgs: widget.data.item.id));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
                  // decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 5.0, color: Colors.grey[100]))),
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Thông tin khóa học", style: TextStyle(fontWeight: FontWeight.bold)).tr(),
                      widget.data.item.content == null
                          ? Container()
                          : ExpandableNotifier(
                              child: ScrollOnExpand(
                                child: Expandable(
                                  collapsed: Column(
                                    children: [
                                      Html(
                                        data: widget.data.item.shortContent ?? "",
                                        shrinkWrap: true,
                                      ),
                                      ExpandableButton(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                          margin: EdgeInsets.only(bottom: 5, top: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(18),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: Offset(0, 2), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            "XEM THÊM",
                                            style: TextStyle(color: Colors.black),
                                          ).tr(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  expanded: Column(children: [
                                    Html(
                                      data: widget.data.item.content ?? "",
                                      shrinkWrap: true,
                                      onLinkTap: (url, _, __, ___) {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => WebviewScreen(
                                                  url: url!,
                                                )));
                                      },
                                    ),
                                    ExpandableButton(
                                        child: Container(
                                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                      margin: EdgeInsets.only(bottom: 5, top: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(18),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(0, 2), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        "THU GỌN",
                                        style: TextStyle(color: Colors.black),
                                      ).tr(),
                                    )),
                                  ]),
                                ),
                              ),
                            ),
                    ],
                  ))),
          HomeClasses(blocks: [HomeClassesDTO(title: "KHOÁ HỌC LIÊN QUAN".tr(), classes: widget.data.hotItems.list)])
        ],
      ),
    );
  }

  void _add2Cart(BuildContext context, String token, int classId) {
    if (user.token == "") {
      Navigator.of(context)
          .pushNamed('/login', arguments: LoginCallback(routeName: "/pdp", routeArgs: widget.data.item.id));
    } else if (!widget.data.item.nolimitTime &&
        DateTime.now().isAfter(DateTime.parse(widget.data.item.dateStart + " " + widget.data.item.timeStart))) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Container(child: Text("Đã quá hạn đăng ký khóa học này.").tr()),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("ĐÃ HIỂU").tr(),
                  ),
                ],
              ));
    } else {
      String url = config.webUrl + "add2cart?class=$classId";
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WebviewScreen(
                url: url,
                token: token,
              )));
    }
  }
}
