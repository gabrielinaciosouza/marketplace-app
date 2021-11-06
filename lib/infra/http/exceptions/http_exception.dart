abstract class HttpException implements Exception {
  final String cause;
  const HttpException(this.cause);
}
