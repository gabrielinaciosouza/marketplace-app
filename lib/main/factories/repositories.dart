import '../../data/data.dart';
import '../main.dart';

String _makeUrl(String path) => 'https://shelf-marketplace.herokuapp.com/$path';

final remoteGetProducts =
    RemoteGetProducts(httpClient, url: _makeUrl('products/'));
