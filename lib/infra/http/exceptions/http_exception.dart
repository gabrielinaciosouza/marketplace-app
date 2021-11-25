import 'package:equatable/equatable.dart';

abstract class HttpException extends Equatable implements Exception {
  final String cause;
  const HttpException(this.cause);
}
