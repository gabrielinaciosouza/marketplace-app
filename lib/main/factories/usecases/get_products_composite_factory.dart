import '../../../domain/domain.dart';
import '../../main.dart';

Future<GetProducts> get makeGetProductsComposite async {
  final localGetProducts = await makeLocalGetProducts;
  final localSaveProducts = await makeLocalSaveProducts;
  return GetProductsComposite(
    makeRemoteGetProducts,
    localSaveProducts,
    localGetProducts,
  );
}
