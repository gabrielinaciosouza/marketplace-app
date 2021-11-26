import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../../main.dart';

Future<LocalSaveCategories> get makeLocalSaveCategories async {
  final hiveAdapter = await makeHiveAdapter(kCategories);
  return LocalSaveCategories(hiveAdapter);
}
