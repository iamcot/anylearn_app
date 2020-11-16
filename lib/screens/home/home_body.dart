import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/home/home_blocs.dart';
import '../../customs/custom_cached_image.dart';
import '../../dto/home_dto.dart';
import '../../dto/user_dto.dart';
import '../../widgets/hot_users.dart';
import '../../widgets/loading_widget.dart';
import 'appbar.dart';
import 'banner.dart';
import 'home_articles.dart';
import 'search_box.dart';
import 'week_courses.dart';
import 'week_courses_header.dart';

class HomeBody extends StatefulWidget {
  final UserDTO user;
  final HomeDTO homeData;
  final HomeBloc homeBloc;

  const HomeBody({Key key, this.user, this.homeData, this.homeBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeBody();
}

class _HomeBody extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.homeData.config.ignorePopupVersion != widget.homeData.config.popup.version &&
          widget.homeData.config.popup.image != null) {
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
                      FlatButton(
                        child: new Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
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
    return CustomScrollView(
      slivers: <Widget>[
        new HomeAppBar(user: widget.user),
        SliverToBoxAdapter(child: SearchBox()),
        // new FeatureList(features:widget.homeData.featuresIcons),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 15.0),
            child: BlocBuilder<HomeBloc, HomeState>(
              bloc: BlocProvider.of<HomeBloc>(context),
              builder: (context, state) {
                if (state is QuoteSuccessState) {
                  return Card(
                    child: ListTile(
                      trailing: Icon(Icons.format_quote),
                      subtitle: Text.rich(
                        TextSpan(
                          text: state.quote.text,
                          style: TextStyle(fontSize: 12),
                          children: [
                            TextSpan(
                                text: " " + state.quote.author,
                                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 11, color: Colors.pink))
                          ],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  );
                } else {
                  return LoadingWidget();
                }
              },
            ),
          ),
        ),
        new HomeBanner(
          imgList: widget.homeData.banners,
          ratio: widget.homeData.config.bannerRatio ?? 0.5625,
        ),
        new HotUsers(
          hotItems: widget.homeData.hotItems,
        ),
        new WeekCourseHeader(),
        new WeekCourses(
          monthCourses: widget.homeData.monthCourses,
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 15.0,
                  color: Colors.grey[100],
                ),
              ),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Học và Hỏi",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("/ask");
                        },
                        child: Text(
                          "XEM THÊM",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        HomeArticles(
          articles: widget.homeData.articles,
        ),
      ],
    );
  }
}
