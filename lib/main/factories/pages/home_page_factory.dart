import 'package:marketplace_app/presentation/presentation.dart';

import '../../main.dart';

HomePage get makeHomePage => HomePage(HomeCubit(makeRemoteGetProducts));
