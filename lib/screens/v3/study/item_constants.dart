
class ItemConstants {
  static const String SUBTYPE_ONLINE = 'online';
  static const String SUBTYPE_DIGITAL = 'digital';
  static const String SUBTYPE_OFFLINE = 'offline';
  static const String SUBTYPE_EXTRA = 'extra';
  static const String SUBTYPE_VIDEO = 'video';
  static const String SUBTYPE_PRESCHOOL = 'preschool';

  static const String DEFAULT_STATUS = 'Đang chờ cập nhật';

  static const List<String> CONFIRMABLE_SUBTYPES = [
    SUBTYPE_EXTRA,
    SUBTYPE_OFFLINE,
    SUBTYPE_ONLINE,
    SUBTYPE_PRESCHOOL,
  ];

  static const List<String> UNCONFIRMABLE_SUBTYPES = [
    SUBTYPE_DIGITAL,
    SUBTYPE_VIDEO,
  ];

  static const Map<String, String> STUBYPES = {
    SUBTYPE_ONLINE: 'Lớp học trực tuyến',
    SUBTYPE_DIGITAL: 'Học qua ứng dụng',
    SUBTYPE_OFFLINE: 'Lớp học chính khóa',
    SUBTYPE_EXTRA: 'Lớp học ngoại khóa',
    SUBTYPE_VIDEO: 'Học qua video',
    SUBTYPE_PRESCHOOL: 'Lớp học mầm non',
  };
  
}