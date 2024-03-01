import 'package:anylearn/app_datetime.dart';
import 'package:anylearn/dto/v3/registered_item_dto.dart';
import 'package:anylearn/screens/v3/study/item_constants.dart';
import 'package:flutter/material.dart';

class ItemSchedule extends StatelessWidget {
  final RegisteredItemDTO data;
  const ItemSchedule({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String locale = Localizations.localeOf(context).toString();
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        children: [
          Positioned (
            right: 0,
            bottom: 25,
            child: Image.asset(
              'assets/images/item_schedule.png',
              fit: BoxFit.contain,
              width: 70,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5.0),
              Container(
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  children: [   
                    _buildScheduleInfo(Icons.school, data.author),
                    const SizedBox(height: 5.0),
                    _buildScheduleInfo(
                      Icons.event, 
                      'Ngày học: ' + AppDateTime.getSchoolDays(data.weekdays, locale),
                    ),
                    const SizedBox(height: 5.0),
                    _buildScheduleInfo(
                      Icons.schedule, 
                      'Thời gian học: ' + AppDateTime.getSchoolTime(data.startTime, data.endTime),
                    ),
                    const SizedBox(height: 5.0),
                    _buildScheduleInfo(
                      Icons.location_on, 
                      data.location.isNotEmpty ? data.location : ItemConstants.DEFAULT_STATUS
                    ),
                  ]
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleInfo(IconData icon, String data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20.0, color: Colors.blue.shade200),
        const SizedBox(width: 8.0),
        Expanded(child: Text(data, maxLines: 2)),
      ],
    );
  }
}