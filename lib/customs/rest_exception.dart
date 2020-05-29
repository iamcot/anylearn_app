class RestException implements Exception {
  final message;
  final prefix;

  RestException([this.message, this.prefix]);

  String toString() => '$prefix|$message';

}

class FetchDataException extends RestException {
  FetchDataException([String message]) : super(message, "Error During Communication: ");
}

class BadRequestException extends RestException {
  static const CODE = 400;
  BadRequestException([message]) : super(message, "Bad Request");
}

class UnauthorizedException extends RestException {
  static const CODE = 401;
  UnauthorizedException([message]) : super(message, "Unauthorized");
}

class ForbiddenException extends RestException {
  static const CODE = 403;
  ForbiddenException([message]) : super(message, "Forbidden");
}

class NotFoundException extends RestException {
  static const CODE = 403;
  NotFoundException([message]) : super(message, "NotFound");
}
