import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../../main.dart';

Future<LocalGetCategories> get makeLocalGetCategories async {
  final hiveAdapter = await makeHiveAdapter(kCategories);

  return LocalGetCategories(hiveAdapter);
}
