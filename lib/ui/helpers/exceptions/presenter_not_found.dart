import 'ui_exception.dart';

class PresenterNotFound extends UIException {
  const PresenterNotFound([String cause = 'No presenter found in context'])
      : super(cause);

  @override
  bool operator ==(Object other) =>
      other is PresenterNotFound &&
      other.runtimeType == runtimeType &&
      other.cause == cause;

  @override
  int get hashCode => cause.hashCode;
}
