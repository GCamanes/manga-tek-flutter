enum ExceptionType { auth, noConnection, noUser, notFound, timeOut, unknown }

class AppException implements Exception {
  AppException({required this.type, this.stackTrace});

  final ExceptionType type;
  final StackTrace? stackTrace;

  @override
  String toString() => '[${type.name}] $stackTrace';
}
