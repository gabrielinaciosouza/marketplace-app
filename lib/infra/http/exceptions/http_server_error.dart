import 'http_exception.dart';

class HttpServerError extends HttpException {
  const HttpServerError([String cause = 'HttpServerError']) : super(cause);

  @override
  List<Object?> get props => [cause];
}
