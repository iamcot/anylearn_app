import 'package:anylearn/screens/home/home_category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/home/home_blocs.dart';
import '../../dto/home_dto.dart';
import '../../dto/user_dto.dart';
import '../../widgets/article_event.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/promotions.dart';
import 'banner.dart';
import 'features.dart';
import 'home_classes.dart';
import 'quote.dart';
import 'search_box.dart';

bool canShowPopup = true;

class HomeBody extends StatefulWidget {
  final UserDTO user;
  final HomeDTO homeData;
  final HomeBloc homeBloc;

  HomeBody({Key key, this.user, this.homeData, this.homeBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeBody();
}

class _HomeBody extends State<HomeBody> {
  List<HomeClassesDTO> homeClasses = [];
  List<HomeClassesDTO> homeClasses2 = [];
  @override
  void initState() {
    super.initState();
    int classLength = widget.homeData.homeClasses.length;
    if (classLength <= 1) {
      homeClasses = widget.homeData.homeClasses;
    } else {
      widget.homeData.homeClasses.asMap().forEach((key, value) {
        if (key < classLength / 2) {
          homeClasses.add(value);
        } else {
          homeClasses2.add(value);
        }
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.homeData.config.ignorePopupVersion != widget.homeData.config.popup.version &&
          widget.homeData.config.popup.image != null &&
          widget.homeData.config.popup.image != "" &&
          canShowPopup) {
        final width = MediaQuery.of(context).size.width;
        final height = width;
        await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              bool showPopupChecked = false;
              return SimpleDialog(
                contentPadding: EdgeInsets.all(5),
                children: [
                  InkWell(
                    onTap: () {
                      if (widget.homeData.config.popup.route != null) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(widget.homeData.config.popup.route,
                            arguments: widget.homeData.config.popup.args);
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        height: height,
                        child: CachedNetworkImage(
                          imageUrl: widget.homeData.config.popup.image,
                          fit: BoxFit.fitWidth,
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          ),
                        )),
                  ),
                  Row(
                    children: [
                      Expanded(child: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                        return CheckboxListTile(
                          value: showPopupChecked,
                          onChanged: (bool value) {
                            setState(() {
                              if (value) {
                                widget.homeBloc
                                  ..add(UpdatePopupVersionEvent(version: widget.homeData.config.popup.version));
                              } else {
                                widget.homeBloc..add(UpdatePopupVersionEvent(version: 0));
                              }
                              showPopupChecked = value;
                            });
                          },
                          title: Text("Không xem lại"),
                          dense: true,
                          contentPadding: EdgeInsets.all(0),
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      })),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"))
                    ],
                  )
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: CustomScrollView(
        slivers: <Widget>[
          new HomeBanner(
            banners: widget.homeData.homeBanner,
            ratio: widget.homeData.config.bannerRatio ?? 0.5625,
          ),
          SliverToBoxAdapter(child: SearchBox()),
          FeatureList(features: widget.homeData.featuresIcons),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 15.0),
              child: BlocBuilder<HomeBloc, HomeState>(
                bloc: BlocProvider.of<HomeBloc>(context),
                builder: (context, state) {
                  if (state is QuoteSuccessState) {
                    return HomeQuote(quote: state.quote);
                  } else {
                    return LoadingWidget();
                  }
                },
              ),
            ),
          ),
          new HomeCategory(
            categories: widget.homeData.categories,
          ),
          new Promotions(
            hotItems: widget.homeData.promotions,
          ),
          new HomeClasses(
            blocks: homeClasses,
          ),
          new HomeArticleEvent(
            hotItems: widget.homeData.events,
            title: "CÁC SỰ KIỆN SẮP XẢY RA",
          ),
          new HomeClasses(
            blocks: homeClasses2,
          ),
          new HomeArticleEvent(
            hotItems: widget.homeData.articles,
            title: "ĐỌC VÀ HỌC",
          ),
        ],
      ),
    );
  }
}
