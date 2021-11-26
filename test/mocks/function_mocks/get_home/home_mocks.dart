import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

class _MockRemoteGetHome extends Mock implements RemoteGetHome {}

RemoteGetHome get mockRemoteGetHome => _MockRemoteGetHome();

When mockGetHomeCall(GetHome getHome) => when(() => getHome.getHome());

void mockGetHomeResponse(GetHome getHome, {Home? response}) =>
    mockGetHomeCall(getHome).thenAnswer((_) async => response ?? baseHome);

void mockGetHomeError(GetHome getHome) =>
    mockGetHomeCall(getHome).thenThrow(Exception());
