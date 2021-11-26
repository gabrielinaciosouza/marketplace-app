import 'package:hive/hive.dart';

import '../../../data/data.dart';
import '../../../infra/infra.dart';

Future<CacheStorage> makeHiveAdapter(String boxName) async {
  final box = await Hive.openBox(boxName);
  return HiveAdapter(box);
}
