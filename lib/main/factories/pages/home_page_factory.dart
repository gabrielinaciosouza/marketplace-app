import '../../../presentation/presentation.dart';
import '../../main.dart';

Future<HomePage> get makeHomePage async {
  final getProductsComposite = await makeGetProductsComposite;

  return HomePage(HomeCubit(getProductsComposite));
}
