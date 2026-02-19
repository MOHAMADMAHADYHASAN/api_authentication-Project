class AppException implements Exception {
  final String? prefix;
  final String? message;

  AppException([this.prefix, this.message]);

  @override
  String toString() {
    return " $prefix:$message ";
  }
}

// data featch exception......................
class FetchDataException extends AppException {
  FetchDataException([String? message])
    : super("Error During Communication:", message);
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super("Invalid request:", message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
    : super("Unauthorised request:", message);
}
