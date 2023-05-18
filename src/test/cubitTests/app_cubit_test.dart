import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_share/cubits/appCubit/app_cubit.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/models/applications.dart';
import 'package:pet_share/models/pet.dart';
import 'package:pet_share/models/user_info.dart';
import 'package:pet_share/services/auth_services.dart';
import 'package:pet_share/services/data_services.dart';

class MockAuthService extends Mock implements AuthService {}

class MockDataService extends Mock implements DataServices2 {}

void main() {
  late MockAuthService mockAuthService;
  late MockDataService mockDataService;
  late AppCubit appCubit;

  setUp(() {
    mockAuthService = MockAuthService();
    mockDataService = MockDataService();
    appCubit = AppCubit(mockDataService, mockAuthService);
  });

  // ja jebie
  // group(
  //   'authUser()',
  //   () {
  //     blocTest<AppCubit, AppState>('description',
  //         setUp: () {
  //           when(() => mockAuthService.authApp())
  //               .thenReturn(true as Future<bool>);
  //           when(
  //             () => mockAuthService.selectAuthFlow(
  //                 initAdopter: () async {},
  //                 initShelter: () async {},
  //                 initUnassigned: () async {}),
  //           );
  //         },
  //         build: () => appCubit,
  //         act: (cubit) => cubit.authUser(),
  //         expect: () => const <AppState>[]);
  //   },
  // );

  group(
    'initAdopter()',
    () {
      String token = 'token';
      Future<List<Announcement2>> resAnn = Future(() => []);
      Future<List<Appplications2>> resApp = Future(() => []);
      Future<List<Pet2>> resPet = Future(() => []);

      blocTest(
        'emits both AppSLoading and AppSLoaded states',
        setUp: () {
          when(() => mockDataService.getAnnouncements(token))
              .thenAnswer((_) => resAnn);
          when(() => mockDataService.getApplications(token))
              .thenAnswer((_) => resApp);
          when(() => mockDataService.getShelterPets(token))
              .thenAnswer((_) => resPet);
          when(() => mockAuthService.accessToken).thenReturn(token);
          when(() => mockAuthService.userInfo).thenReturn(
            UserInfo(
                role: UserRoles.unknown,
                nickname: 'nickname',
                accessToken: token),
          );
        },
        build: () => appCubit,
        act: (cubit) => cubit.initAdopter(),
        expect: () => [
          isA<AppSLoading>(),
          isA<AppSLoaded>(),
        ],
        verify: (bloc) {
          verify(() => mockDataService.getAnnouncements(token)).called(1);
          verify(() => mockDataService.getApplications(token)).called(1);
          verify(() => mockDataService.getShelterPets(token)).called(1);
        },
      );

      blocTest(
        'throws and catches exception',
        setUp: () {
          when(() => mockDataService.getAnnouncements(token))
              .thenThrow(Exception());
        },
        build: () => appCubit,
        act: (cubit) => cubit.initAdopter(),
        expect: () => [
          isA<AppSLoading>(),
        ],
        verify: (bloc) {
          verifyNever(() => mockDataService.getAnnouncements(token));
          verifyNever(() => mockDataService.getApplications(token));
          verifyNever(() => mockDataService.getShelterPets(token));
        },
      );
    },
  );
}
