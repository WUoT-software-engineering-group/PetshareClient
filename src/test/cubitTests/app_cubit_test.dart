import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_share/cubits/appCubit/app_cubit.dart';
import 'package:pet_share/models/address.dart';
import 'package:pet_share/models/adopter.dart';
import 'package:pet_share/models/shelter.dart';
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
    appCubit = AppCubit(mockDataService, mockAuthService, reaction: (_) {});
  });

  group(
    'authUser()',
    () {
      blocTest(
        'calls selectAuthFlow when signin was succesful',
        setUp: () {
          when(() => mockAuthService.authApp())
              .thenAnswer((_) => Future(() => true));
          when(() => mockAuthService.selectAuthFlow(
                initAdopter: appCubit.initAdopter,
                initShelter: appCubit.initShelter,
                initUnassigned: appCubit.initUnassigned,
              )).thenAnswer((invocation) => Future(() => null));
        },
        build: () => appCubit,
        act: (cubit) => cubit.authUser(),
        verify: (bloc) {
          verify(() => mockAuthService.authApp()).called(1);
          verify(() => mockAuthService.selectAuthFlow(
                initAdopter: appCubit.initAdopter,
                initShelter: appCubit.initShelter,
                initUnassigned: appCubit.initUnassigned,
              )).called(1);
        },
      );

      blocTest(
        'does nothing when signin was not succesful',
        setUp: () {
          when(() => mockAuthService.authApp())
              .thenAnswer((_) => Future(() => false));
        },
        build: () => appCubit,
        act: (cubit) => cubit.authUser(),
        verify: (bloc) {
          verify(() => mockAuthService.authApp()).called(1);
          verifyNever(() => mockAuthService.selectAuthFlow(
                initAdopter: appCubit.initAdopter,
                initShelter: appCubit.initShelter,
                initUnassigned: appCubit.initUnassigned,
              ));
        },
      );

      blocTest(
        'throws and catches exception',
        setUp: () {
          when(() => mockAuthService.authApp())
              .thenAnswer((_) => Future(() => true));
          when(() => mockAuthService.selectAuthFlow(
                initAdopter: appCubit.initAdopter,
                initShelter: appCubit.initShelter,
                initUnassigned: appCubit.initUnassigned,
              )).thenThrow(Exception());
        },
        build: () => appCubit,
        act: (cubit) => cubit.authUser(),
        verify: (bloc) {
          verify(() => mockAuthService.authApp()).called(1);
          expect(
            () => mockAuthService.selectAuthFlow(
              initAdopter: appCubit.initAdopter,
              initShelter: appCubit.initShelter,
              initUnassigned: appCubit.initUnassigned,
            ),
            throwsA(isA<Exception>()),
          );
        },
      );
    },
  );

  group(
    'logoutUser()',
    () {
      blocTest(
        'emits both AppSLoading and AppSInitial states, calls logoutUser',
        setUp: () {
          when(() => mockAuthService.logoutUser())
              .thenAnswer((_) => Future(() => null));
        },
        build: () => appCubit,
        act: (cubit) => cubit.logoutUser(),
        expect: () => [
          isA<AppSLoading>(),
          isA<AppSInitial>(),
        ],
        verify: (bloc) {
          verify(() => mockAuthService.logoutUser()).called(1);
        },
      );
    },
  );

  group(
    'setAdopter()',
    () {
      String token = 'token';
      CreatingAdopter adopter = CreatingAdopter(
        userName: 'userName',
        phoneNumber: 'phoneNumber',
        email: 'email',
        address: Address2(
            street: 'street',
            city: 'city',
            provice: 'provice',
            postalCode: 'postalCode',
            country: 'country'),
      );
      String idUser = 'idUser';

      blocTest(
        'emits AppSLoading state, calls postAdopter, setRole for setting adopter\'s role and initAdopter',
        setUp: () {
          when(() => mockDataService.postAdopter(adopter, token))
              .thenAnswer((_) => Future(() => idUser));
          when(() => mockAuthService.setRole(UserRoles.adopter, idUser))
              .thenAnswer((_) => Future(() => null));
          when(() => appCubit.initAdopter())
              .thenAnswer((_) => Future(() => null));
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.setAddopter(adopter),
        verify: (cubit) {
          expect(cubit.state, isA<AppSLoading>());
          verify(() => mockDataService.postAdopter(adopter, token)).called(1);
          verify(() => mockAuthService.setRole(UserRoles.adopter, idUser))
              .called(1);
        },
      );
    },
  );

  group(
    'setShelter()',
    () {
      String token = 'token';
      CreatingShelter shelter = CreatingShelter(
        userName: 'userName',
        phoneNumber: 'phoneNumber',
        email: 'email',
        fullShelterName: 'fullShelterName',
        address: Address2(
            street: 'street',
            city: 'city',
            provice: 'province',
            postalCode: 'postalCode',
            country: 'country'),
      );
      String idUser = 'idUser';

      blocTest(
        'emits AppSLoading state, calls postShelter, setRole for setting shelter\'s role and initShelter',
        setUp: () {
          when(() => mockDataService.postShelter(shelter, token))
              .thenAnswer((_) => Future(() => idUser));
          when(() => mockAuthService.setRole(UserRoles.shelter, idUser))
              .thenAnswer((_) => Future(() => null));
          when(() => appCubit.initShelter())
              .thenAnswer((_) => Future(() => null));
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.setShelter(shelter),
        verify: (cubit) {
          expect(cubit.state, isA<AppSLoading>());
          verify(() => mockDataService.postShelter(shelter, token)).called(1);
          verify(() => mockAuthService.setRole(UserRoles.shelter, idUser))
              .called(1);
        },
      );
    },
  );

  group(
    'initShelter()',
    () {
      String token = 'token';

      blocTest(
        'emits both AppSLoading and AppSLoaded states',
        setUp: () {
          when(() => mockDataService.getShelterAnnouncements(token))
              .thenAnswer((_) => Future(() => []));
          when(() => mockDataService.getApplications(token))
              .thenAnswer((_) => Future(() => []));
          when(() => mockDataService.getShelterPets(token))
              .thenAnswer((_) => Future(() => []));
          when(() => mockAuthService.accessToken).thenReturn(token);
          when(() => mockAuthService.userInfo).thenReturn(
            UserInfo(
                role: UserRoles.unknown,
                nickname: 'nickname',
                accessToken: token),
          );
        },
        build: () => appCubit,
        act: (cubit) => cubit.initShelter(),
        expect: () => [
          isA<AppSLoading>(),
          isA<AppSLoaded>(),
        ],
        verify: (bloc) {
          verify(() => mockDataService.getShelterAnnouncements(token))
              .called(1);
          verify(() => mockDataService.getApplications(token)).called(1);
          verify(() => mockDataService.getShelterPets(token)).called(1);
        },
      );

      blocTest(
        'throws and catches exception',
        setUp: () {
          when(() => mockDataService.getShelterAnnouncements(token))
              .thenThrow(Exception());
        },
        build: () => appCubit,
        act: (cubit) => cubit.initShelter(),
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

  group(
    'initAdopter()',
    () {
      String token = 'token';

      blocTest(
        'emits both AppSLoading and AppSLoaded states',
        setUp: () {
          when(() => mockDataService.getAnnouncements(token))
              .thenAnswer((_) => Future(() => []));
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
        },
      );
    },
  );

  group(
    'initUnassigned()',
    () {
      blocTest(
        'emits AppSAuthed state',
        build: () => appCubit,
        act: (cubit) => cubit.initUnassigned(),
      );
    },
  );
}
