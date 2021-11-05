import '../../domain/domain.dart';
import '../data.dart';

class RemoteGetProducts implements GetProducts {
  final HttpClient _httpClient;
  final String url;

  const RemoteGetProducts(this._httpClient, {required this.url});
  @override
  Future<List<Product>> getProducts() async {
    final result = await _httpClient.get(url: url);

    final products = result['products'] as List<dynamic>;

    return products
        .map((product) => ProductData.fromJson(product).toEntity())
        .toList();
  }
}
