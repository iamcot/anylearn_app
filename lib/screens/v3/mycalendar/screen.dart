import 'package:anylearn/screens/v3/mycalendar/calendar.dart';
import 'package:anylearn/screens/v3/mycalendar/course_info.dart';
import 'package:anylearn/screens/v3/mycalendar/courses.dart';
import 'package:anylearn/screens/v3/mycalendar/intro.dart';
import 'package:anylearn/screens/v3/mycalendar/item_course.dart';
import 'package:anylearn/screens/v3/mycalendar/item_schedule.dart';
import 'package:anylearn/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            CourseInfo()
            //Calendar()
            // Intro(),
            // Courses(
            //   title: 'Khóa học tham gia',
            //   intro: 'Đây là các khóa học bạn đang hoặc chuẩn bị tham gia.',
            //   itemBuilder: (index) => ItemCourse(index),
            // ),
            // Courses(
            //   title: 'Lịch học hôm nay',
            //   intro: 'Đây là lịch học hôm nay của bạn.',
            //  itemBuilder: (index) => ItemSchedule(index),
            // ),
            // Courses(
            //   title: 'Khóa học hoàn thành',
            //   intro: 'Đây là các khóa học bạn đã hoàn thành.',
            //   itemBuilder: (index) => ItemCourse(index),
            // ),
            
          ]
        ),
      ),
      bottomNavigationBar: BottomNav(BottomNav.MYCLASS_INDEX),
    );
  }
}