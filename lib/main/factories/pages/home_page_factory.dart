import '../../../presentation/presentation.dart';
import '../../main.dart';

Future<HomePage> get makeHomePage async {
  final getHomeComposite = await makeGetHomeComposite;

  return HomePage(
      HomeCubit(getHomeComposite, makeRemoteGetProductsByCategoryId));
}
