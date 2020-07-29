import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/home/home_blocs.dart';
import '../../dto/home_dto.dart';
import '../../dto/user_dto.dart';
import '../../widgets/hot_users.dart';
import '../../widgets/loading_widget.dart';
import 'appbar.dart';
import 'banner.dart';
import 'search_box.dart';
import 'week_courses.dart';
import 'week_courses_header.dart';

class HomeBody extends StatelessWidget {
  final UserDTO user;
  final HomeDTO homeData;

  HomeBody({Key key, this.user, this.homeData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        new HomeAppBar(user: user),
        SliverToBoxAdapter(child: SearchBox()),
        // new FeatureList(features: homeData.featuresIcons),
        new HomeBanner(
          imgList: homeData.banners,
        ),
        new HotUsers(
          hotItems: homeData.hotItems,
        ),
        new WeekCourseHeader(),
        new WeekCourses(
          monthCourses: homeData.monthCourses,
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
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
      ],
    );
  }
}
