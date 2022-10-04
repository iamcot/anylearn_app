import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../blocs/course/course_blocs.dart';
import '../dto/user_dto.dart';
import '../main.dart';
import '../widgets/gradient_button.dart';
import '../widgets/loading_widget.dart';

class RatingInputScreen extends StatefulWidget {
  final UserDTO user;
  final itemId;
  final itemTitle;
  final lastRating;

  const RatingInputScreen({required this.user, this.itemId, this.itemTitle, this.lastRating});

  @override
  State<StatefulWidget> createState() => _RatingInputScreen();
}

class _RatingInputScreen extends State<RatingInputScreen> {
  late CourseBloc _courseBloc;
  int score = 5;
  final max = 5;
  int current = 1;
  final _commentInput = TextEditingController();

  @override
  void didChangeDependencies() {
    _courseBloc = BlocProvider.of<CourseBloc>(context);
    if (widget.lastRating > 0) {
      score = widget.lastRating;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
        Text('title').tr();

    return BlocListener(
      bloc: _courseBloc,
      listener: (context, state) {
        if (state is ReviewSubmitSuccessState) {
          toast("Cảm ơn bạn đã gửi nhận xét về khóa học.".tr(), duration: Duration(seconds: 3));
          Navigator.of(context).pop(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Đánh giá về khóa học").tr(),
          centerTitle: false,
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text("Đánh giá của bạn rất quan trọng để chúng tôi cải thiện mỗi ngày.").tr(),
            Card(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cho điểm ".tr() + widget.itemTitle,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Row(
                        children: _buildStar(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bình luận thêm về ".tr() + widget.itemTitle,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _commentInput,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Hãy chia sẻ thêm cảm nhận của bạn về buổi học nhé.".tr(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            BlocBuilder(
                bloc: _courseBloc,
                builder: (context, state) {
                  if (state is ReviewSubmitingState) {
                    return LoadingWidget();
                  }
                  return GradientButton(
                    title: "LƯU NHẬN XÉT".tr(),
                    function: () {
                      _courseBloc
                        ..add(ReviewSubmitEvent(
                            token: user.token,
                            itemId: widget.itemId,
                            rating: score,
                            comment: _commentInput.text));
                    },
                  );
                })
          ]),
        ),
      ),
    );
  }

  void _getScore(int _score) {
    setState(() {
      score = _score;
    });
  }

  List<Widget> _buildStar() {
    List<int> scores = [1, 2, 3, 4, 5];
    List<Widget> list = [];

    scores.forEach((_score) {
      list.add(Padding(
        padding: EdgeInsets.all(0.0),
        child: IconButton(
          icon: _score <= score
              ? Icon(
                  Icons.star,
                  size: 32,
                  color: Colors.orange[200],
                )
              : Icon(
                  Icons.star_border,
                  size: 32,
                  color: Colors.grey,
                ),
          onPressed: () {
            _getScore(_score);
          },
        ),
      ));
    });
    return list;
  }
}
