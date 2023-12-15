// import 'package:anylearn/screens/v3/study/item_schedule.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:intl/intl.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:timelines/timelines.dart';

// class Calendar extends StatefulWidget {
//   const Calendar({Key? key}) : super(key: key);

//   @override
//   State<Calendar> createState() => _CalendarState();
// }

// class _CalendarState extends State<Calendar> {
//   DateTime? _selectedDay;
//   DateTime? _focusedDay;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TableCalendar(
//             firstDay: DateTime.utc(2010, 10, 16),
//             lastDay: DateTime.utc(2030, 3, 14),
//             focusedDay: DateTime.now(),
//             selectedDayPredicate: (day) {
//               return isSameDay(_selectedDay, day);
//             },
//             onDaySelected: (selectedDay, focusedDay) {
//               setState(() {
//                 _selectedDay = selectedDay;
//                 _focusedDay = focusedDay; // update `_focusedDay` here as well
//               });
//             },
//             calendarFormat: CalendarFormat.week,
//           ),
//           Container(
//             padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
//             child: FixedTimeline.tileBuilder(
//               builder: TimelineTileBuilder.connectedFromStyle(
//                 nodePositionBuilder: (context, index) => 0.15,
//                 indicatorPositionBuilder: (context, index) => 0,
//                 connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
//                 indicatorStyleBuilder: (context, index) => IndicatorStyle.outlined,

//                 itemExtent: 180.0,
//                 itemCount: 3, 
//                 oppositeContentsBuilder: (context, index) => Text('12:00'),
//                 contentsBuilder: (context, index) => SizedBox(height:150, child: ItemSchedule(index)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }