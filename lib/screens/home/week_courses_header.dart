import 'package:flutter/material.dart';

class WeekCourseHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "Khóa học sắp diễn ra",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/event");
                  },
                  child: Text(
                    "Khóa học khác",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
