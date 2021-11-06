import 'http_exception.dart';

class HttpServerError extends HttpException {
  const HttpServerError([String cause = 'HttpServerError']) : super(cause);

  @override
  bool operator ==(Object other) =>
      other is HttpServerError &&
      other.runtimeType == runtimeType &&
      other.cause == cause;

  @override
  int get hashCode => cause.hashCode;
}
