import 'package:equatable/equatable.dart';

class PresentationError with EquatableMixin {
  final bool errorOcurred;
  final String message;

  const PresentationError({required this.errorOcurred, this.message = ''});

  @override
  List<Object?> get props => [errorOcurred, message];
}
