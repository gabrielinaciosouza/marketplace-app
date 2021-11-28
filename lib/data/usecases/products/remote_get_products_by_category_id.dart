import '../../../domain/domain.dart';
import '../../data.dart';

class RemoteGetProductsByCategoryId implements GetProductsByCategoryId {
  final HttpClient _httpClient;
  final String url;

  const RemoteGetProductsByCategoryId(this._httpClient, {required this.url});

  @override
  Future<List<Product>> getProductsByCategoryId(String categoryId) async {
    try {
      final result = await _httpClient.get(url: '$url$categoryId');

      final List<dynamic>? products = result?[kProducts];

      if (products == null) throw const ServerError();

      return products
          .map((product) => ProductData.fromJson(product).toEntity())
          .toList();
    } catch (error) {
      throw const ServerError();
    }
  }
}
