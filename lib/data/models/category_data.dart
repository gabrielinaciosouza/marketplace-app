import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';

class CategoryData with EquatableMixin {
  final String id;
  final String name;

  const CategoryData({
    required this.id,
    required this.name,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) =>
      CategoryData(id: json['id'], name: json['name']);

  Category toEntity() => Category(id: id, name: name);

  factory CategoryData.fromEntity(Category category) =>
      CategoryData(id: category.id, name: category.name);

  Map<String, dynamic> toMap() => {'id': id, 'name': name};

  @override
  List<Object?> get props => [id, name];
}
