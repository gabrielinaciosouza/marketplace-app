import '../../domain/domain.dart';
import '../presentation.dart';

mixin ErrorHandler {
  PresentationError handleError(DomainException domainException) {
    return PresentationError.serverError;
  }
}
