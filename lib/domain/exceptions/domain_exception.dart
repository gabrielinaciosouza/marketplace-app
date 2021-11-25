import 'package:equatable/equatable.dart';

abstract class DomainException extends Equatable implements Exception {
  final String cause;
  const DomainException(this.cause);
}
