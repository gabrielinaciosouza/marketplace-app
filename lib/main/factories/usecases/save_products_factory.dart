import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../../main.dart';

Future<LocalSaveProducts> get makeLocalSaveProducts async {
  final hiveAdapter = await makeHiveAdapter(kProducts);
  return LocalSaveProducts(hiveAdapter);
}
