import 'package:marketplace_app/domain/domain.dart';

import '../presentation.dart';

mixin ErrorHandler {
  PresentationError handleError(DomainException domainException) {
    return PresentationError.serverError;
  }
}
