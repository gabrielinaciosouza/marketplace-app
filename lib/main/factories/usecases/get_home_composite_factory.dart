import '../../../domain/domain.dart';
import '../../main.dart';

Future<GetHome> get makeGetHomeComposite async {
  final localGetProducts = await makeLocalGetProducts;
  final localSaveProducts = await makeLocalSaveProducts;
  final localSaveCategories = await makeLocalSaveCategories;
  final localGetCategories = await makeLocalGetCategories;

  return HomeComposite(
    makeRemoteGetHome,
    localSaveProducts,
    localSaveCategories,
    localGetProducts,
    localGetCategories,
  );
}
