import 'domain_exception.dart';

class ServerError extends DomainException {
  const ServerError([String cause = 'ServerError']) : super(cause);

  @override
  bool operator ==(Object other) =>
      other is ServerError &&
      other.runtimeType == runtimeType &&
      other.cause == cause;

  @override
  int get hashCode => cause.hashCode;
}
