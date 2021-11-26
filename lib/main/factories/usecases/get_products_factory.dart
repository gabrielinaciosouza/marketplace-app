import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../../main.dart';

RemoteGetProducts get makeRemoteGetProducts =>
    RemoteGetProducts(makeHttpClient, url: makeApiUrl('$kHome/'));
