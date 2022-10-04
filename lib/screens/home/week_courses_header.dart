import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WeekCourseHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        Text('title').tr();

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "Khóa học sắp diễn ra".tr(),
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
                    "KHÓA HỌC KHÁC".tr(),
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
    );
  }
}
