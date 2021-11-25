import 'domain_exception.dart';

class ServerError extends DomainException {
  const ServerError([String cause = 'ServerError']) : super(cause);

  @override
  List<Object?> get props => [cause];
}
