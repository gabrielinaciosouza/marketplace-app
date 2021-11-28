import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../../main.dart';

RemoteGetProductsByCategoryId get makeRemoteGetProductsByCategoryId =>
    RemoteGetProductsByCategoryId(makeHttpClient,
        url: makeApiUrl('$kProducts/$kCategory/'));
