import 'package:anylearn/dto/v3/schedule_dto.dart';
import 'package:anylearn/screens/v3/study/calendar_screen.dart';
import 'package:flutter/material.dart';

class ItemSchedule extends StatelessWidget {
  final ScheduleDTO data;
  const ItemSchedule({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CalendarScreen())),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.amber.shade50,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Stack(
          children: [
            Positioned (
              right: 0,
              bottom: 15,
              child: Image.asset(
                'assets/images/item_schedule.png',
                fit: BoxFit.contain,
                width: 80,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    data.course,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                _buildScheduleInfo(Icons.school, data.author),
                const SizedBox(height: 5),
                _buildScheduleInfo(Icons.event, data.dateOn),
                const SizedBox(height: 5),
                _buildScheduleInfo(Icons.schedule, '${data.startTime} - ${data.endTime}'),
                const SizedBox(height: 5),
                _buildScheduleInfo(Icons.location_on, data.locationOn),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleInfo(IconData icon, String data) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.cyan.shade300),
        const SizedBox(width: 5),
        Expanded(child: Text(data)),
      ],
    );
  } 
}