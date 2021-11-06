import '../../ui/ui.dart';
import '../presentation.dart';

extension ValidationErrorExtension on PresentationError {
  String get description {
    return R.strings.serverErrorMessage;
  }
}
