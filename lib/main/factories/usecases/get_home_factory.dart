import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../../main.dart';

RemoteGetHome get makeRemoteGetHome =>
    RemoteGetHome(makeHttpClient, url: makeApiUrl('$kHome/'));
