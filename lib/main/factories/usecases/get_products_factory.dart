import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../../main.dart';

GetProducts get makeRemoteGetProducts =>
    RemoteGetProducts(makeHttpClient, url: makeApiUrl('products/'));
