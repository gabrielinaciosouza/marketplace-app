import 'package:marketplace_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

class _MockGetProductsByCategoryId extends Mock
    implements GetProductsByCategoryId {}

_MockGetProductsByCategoryId get mockGetProductsByCategoryId =>
    _MockGetProductsByCategoryId();

When mockGetProductsByCategoryIdCall(
        GetProductsByCategoryId getProductsByCategoryId,
        {required String id}) =>
    when(() => getProductsByCategoryId.getProductsByCategoryId(id));

void mockGetProductsByCategoryIdResponse(
        GetProductsByCategoryId getProductsByCategoryId,
        {List<Product>? response,
        required String id}) =>
    mockGetProductsByCategoryIdCall(
      getProductsByCategoryId,
      id: id,
    ).thenAnswer((_) async => response ?? [baseProduct]);

void mockGetProductsByCategoryIdError(
        {required GetProductsByCategoryId getProductsByCategoryId,
        required String id}) =>
    mockGetProductsByCategoryIdCall(getProductsByCategoryId, id: id)
        .thenThrow(Exception());
