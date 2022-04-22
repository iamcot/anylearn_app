class RestException implements Exception {
  final message;
  final prefix;

  RestException([this.message, this.prefix]);

  String toString() => '$prefix | $message';

}

class FetchDataException extends RestException {
  FetchDataException([message]) : super(message, "Có lỗi xảy ra");
}

class BadRequestException extends RestException {
  static const CODE = 400;
  BadRequestException([message]) : super(message, "Dữ liệu không đúng");
}

class UnauthorizedException extends RestException {
  static const CODE = 401;
  UnauthorizedException([message]) : super(message, "Không xác thực");
}

class ForbiddenException extends RestException {
  static const CODE = 403;
  ForbiddenException([message]) : super(message, "Không có quyền");
}

class NotFoundException extends RestException {
  static const CODE = 403;
  NotFoundException([message]) : super(message, "Không tìm thấy");
}
