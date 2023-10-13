import 'package:anylearn/customs/custom_cached_image.dart';
import 'package:flutter/material.dart';

import '../../widgets/rating.dart';
import '../../widgets/sliver_banner.dart';
import 'teacher_filter.dart';

class TeacherBody extends StatelessWidget {
  final teachers;

  TeacherBody({this.teachers});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    return CustomScrollView(
      slivers: <Widget>[
        SliverBanner(
          banner: teachers.banner,
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
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("/items/teacher", arguments: teachers.list.data[index].id);
                },
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: (Colors.grey[100])!,
                        width: 1.0,
                      ),
                      bottom: BorderSide(
                        color: (Colors.grey[100])!,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width - 40,
                          height: width - 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(width / 2),
                            child: teachers.list.data[index].image != null && teachers.list.data[index].image != ""
                                ? CustomCachedImage(
                                    url: teachers.list.data[index].image,
                                  )
                                : SizedBox(
                                    child: Icon(
                                      Icons.account_circle,
                                      size: width - 40,
                                      color: Colors.grey,
                                    ),
                                  ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5.0),
                          margin: EdgeInsets.only(top: 5.0),
                          
                          child: teachers.list.data[index].title != null
                              ? Text(
                                  teachers.list.data[index].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 10.0),
                                )
                              : SizedBox(height: 0),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            teachers.list.data[index].name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 5.0),
                          child: RatingBox(score: teachers.list.data[index].rating),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: teachers.list.data.length,
          ),
        ),
      ],
    );
  }
}
