import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures.dart';

class _MockLocalSaveCategories extends Mock implements LocalSaveCategories {}

class _MockLocalGetCategories extends Mock implements LocalGetCategories {}

LocalSaveCategories get mockLocalSaveCategories => _MockLocalSaveCategories();
LocalGetCategories get mockLocalGetCategories => _MockLocalGetCategories();

When mockSaveCategoriesCall(SaveCategories saveCategories) =>
    when(() => saveCategories.saveCategories([baseCategory]));

void mockSaveCategoriesResponse(SaveCategories saveCategories,
        {List<Category>? response}) =>
    mockSaveCategoriesCall(saveCategories)
        .thenAnswer((_) async => response ?? [baseCategory]);

When mockGetLocalCategoriesCall(GetCategories getCategories) =>
    when(() => getCategories.getCategories());

void mockGetLocalCategoriesResponse(GetCategories getCategories,
        {List<Category>? response}) =>
    mockGetLocalCategoriesCall(getCategories)
        .thenAnswer((_) async => response ?? [baseCategory]);
