import 'translations.dart';

class PtBr implements Translations {
  @override
  String get appBarHomePageTitle => 'Marketplace';

  @override
  String get appTitle => 'Marketplace';

  @override
  String get serverErrorMessage => 'Erro! Por favor, tente novamente.';

  @override
  String get retry => 'Recarregar';

  @override
  String get emptyList => 'Lista Vazia';
}
