import 'package:anylearn/blocs/course/course_blocs.dart';
import 'package:anylearn/dto/item_user_action.dart';
import 'package:anylearn/widgets/loading_widget.dart';
import 'package:anylearn/widgets/rating.dart';
import 'package:anylearn/widgets/time_ago.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ItemRatingScreen extends StatefulWidget {
  final int itemId;

  const ItemRatingScreen({Key key, this.itemId}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ItemRatingScreen();
}

class _ItemRatingScreen extends State<ItemRatingScreen> {
  CourseBloc _courseBloc;
  List<ItemUserAction> data;
  @override
  void didChangeDependencies() {
    _courseBloc = BlocProvider.of<CourseBloc>(context)..add(ReviewLoadEvent(itemId: widget.itemId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Các đánh giá của khóa học"),
        centerTitle: false,
      ),
      body: BlocBuilder(
          bloc: _courseBloc,
          builder: (context, state) {
            if (state is ReviewLoadSuccessState) {
              data = state.data;
            }
            return data == null
                ? LoadingWidget()
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          width: 50,
                          child: data[index].userImage == null
                              ? Icon(Icons.account_circle)
                              : CachedNetworkImage(imageUrl: data[index].userImage),
                        ),
                        title: Container(
                            child: RatingBox(
                          score: double.parse(data[index].value),
                          alignment: "start",
                        )),
                        trailing: TimeAgo(time: data[index].createdAt),
                        isThreeLine: true,
                        subtitle: Text.rich(TextSpan(
                            text: data[index].userName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            children: [
                              TextSpan(
                                  text: data[index].extraValue == null ? "" : "\n" + data[index].extraValue,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54,
                                  ))
                            ])),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: data.length,
                  );
          }),
    );
  }
}
