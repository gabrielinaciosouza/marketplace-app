import '../../../domain/domain.dart';
import '../../data.dart';

class RemoteGetHome implements GetHome {
  final HttpClient _httpClient;
  final String url;

  const RemoteGetHome(this._httpClient, {required this.url});
  @override
  Future<Home> getHome() async {
    try {
      final result = await _httpClient.get(url: url);

      if (result == null) throw const ServerError();

      return HomeData.fromJson(result).toEntity();
    } catch (error) {
      throw const ServerError();
    }
  }
}
