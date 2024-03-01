import 'package:anylearn/screens/v3/study/item_constants.dart';
import 'package:intl/intl.dart';

class AppDateTime {
  static const String DEFAULT_DATE_FORMAT = 'yyyy-MM-dd';
  static const String REVERSE_DATE_FORMAT = 'dd-MM-yyyy';
  static const String DEFAULT_TIME_FORMAT = 'hh:mm a';

  static const Map<String, List<String>> _DAYS_OF_WEEK = {
    'en': ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
    'vi': ['Chủ Nhật', 'Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy'],
  };

  static List<String> getDaysOfWeek(String locale) {
    return _DAYS_OF_WEEK.containsKey(locale) ? _DAYS_OF_WEEK[locale]! : [];
  }

  static String convertDateFormat(String datetime, { String? format, bool reverse = false}) {
    try {
      final String defaultFormat = reverse ? REVERSE_DATE_FORMAT : DEFAULT_DATE_FORMAT;
      return DateFormat(format ?? defaultFormat).format(DateTime.parse(datetime));
    } catch (e) {
      print('Error parsing datetime: $e');
      return '';
    }
  }

  static String convertTimeFormat(String datetime) {
    try {
      final String defaultFormat = '1970-01-01 $datetime';
      return DateFormat(DEFAULT_TIME_FORMAT).format(DateTime.parse(defaultFormat));
    } catch (e) {
      print('Error parsing datetime: $e');
      return '';
    }
  }

    static String getSchoolDays(String days, String locale) {  
    final List<String> daysOfWeek = AppDateTime.getDaysOfWeek(locale);
    if (days.isNotEmpty) {
      final List<String> schoolDays = days.split(',').map((e) => daysOfWeek[int.parse(e) - 1]).toList();
      return schoolDays.join(', ');
    }
    return ItemConstants.DEFAULT_STATUS;
  }
  
  static String getSchoolTime(String startTime, String endTime) {
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
