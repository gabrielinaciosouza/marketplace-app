abstract class DomainException implements Exception {
  final String cause;
  const DomainException(this.cause);
}
