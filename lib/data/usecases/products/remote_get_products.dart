import '../../../domain/domain.dart';
import '../../data.dart';

class RemoteGetProducts implements GetProducts {
  final HttpClient _httpClient;
  final String url;

  const RemoteGetProducts(this._httpClient, {required this.url});
  @override
  Future<List<Product>> getProducts() async {
    try {
      final result = await _httpClient.get(url: url);

      final List<dynamic>? products = result?['products'];

      if (products == null) throw const ServerError();

      return products
          .map((product) => ProductData.fromJson(product).toEntity())
          .toList();
    } catch (error) {
      throw const ServerError();
    }
  }
}
