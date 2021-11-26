import 'package:equatable/equatable.dart';

class Category with EquatableMixin {
  final String id;
  final String name;

  const Category({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
