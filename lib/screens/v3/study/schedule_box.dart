import 'package:anylearn/app_datetime.dart';
import 'package:anylearn/dto/v3/registered_item_dto.dart';
import 'package:anylearn/screens/v3/study/item_constants.dart';
import 'package:anylearn/widgets/bold_text.dart';
import 'package:anylearn/widgets/title_text.dart';
import 'package:flutter/material.dart';

class ScheduleBox extends StatelessWidget {
  final RegisteredItemDTO data;
  final Function() confirmationCallback;

  final Color? iconColor;
  final Color? keyColor;

  ScheduleBox({
    Key? key, 
    required this.data, 
    required this.confirmationCallback,
    this.iconColor,
    this.keyColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String locale = Localizations.localeOf(context).toString();
    return Container(
      padding: EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText('Thời khóa biểu'),
          const SizedBox(height: 15.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: iconColor, size: 20),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  _getParticipationText(data.participantConfirm), 
                  maxLines: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.event, color: iconColor, size: 20),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(_getCoursePeriod(data.startDate, data.endDate))
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on, color: iconColor, size: 20),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  data.location.isNotEmpty ?  data.location : ItemConstants.DEFAULT_STATUS, 
                  maxLines: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: keyColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 75, child: BoldText('Ngày học:')),
                    Expanded(
                      child: Text(_getSchoolDays(data.weekdays, locale), maxLines: 2)
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    SizedBox(width: 75, child: BoldText('Thời gian:')),
                    Expanded(
                      child: Text(_getSchoolTime(data.startTime, data.endTime))
                    ),
                  ],
                ),
              ]
            ),
          ),
          if (0 == data.participantConfirm)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => confirmationCallback(),
                child: Text('Tham gia', style: TextStyle(fontSize: 16)),
              ),
            ],
          )
        ],
      ),
    );
  }

  String _getParticipationText(int participated) {
    final String confirmed = 'Bạn chưa tham gia khóa học này';
    final String unconfirmed = 'Bạn chưa tham gia khóa học này';
    return 0 == participated ? confirmed : unconfirmed;
  }

  String _getCoursePeriod(String startDate, String endDate) {
    final String convertedStartDate = AppDateTime.convertDateFormat(startDate, reverse: true);
    final String convertedEndDate = AppDateTime.convertDateFormat(endDate, reverse: true);
    if (startDate.isNotEmpty && endDate.isNotEmpty) {
      return 'Từ $convertedStartDate đến $convertedEndDate';
    }
    if (startDate.isNotEmpty && endDate.isEmpty) {
      return 'Từ $convertedStartDate';
    }
    return ItemConstants.DEFAULT_STATUS;
  }

  String _getSchoolDays(String days, String locale) {  
    final List<String> daysOfWeek = AppDateTime.getDaysOfWeek(locale);
    if (days.isNotEmpty) {
      final List<String> schoolDays = days.split(',').map((e) => daysOfWeek[int.parse(e) - 1]).toList();
      return schoolDays.join(', ');
    }
    return ItemConstants.DEFAULT_STATUS;
  }
  
  String _getSchoolTime(String startTime, String endTime) {
    final String convertedStartTime = AppDateTime.convertTimeFormat(startTime);
    final String convertedEndTime = AppDateTime.convertTimeFormat(endTime);
    if (startTime.isNotEmpty && endTime.isNotEmpty) {
      return '$convertedStartTime - $convertedEndTime';
    }
    if (startTime.isNotEmpty && endTime.isEmpty) {
      return convertedStartTime;
    }
    return ItemConstants.DEFAULT_STATUS;
  }
}