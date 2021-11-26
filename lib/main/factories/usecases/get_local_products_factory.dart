import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../../main.dart';

Future<LocalGetProducts> get makeLocalGetProducts async {
  final hiveAdapter = await makeHiveAdapter(kProducts);
  return LocalGetProducts(hiveAdapter);
}
