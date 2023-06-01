import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_share/cubits/appCubit/app_cubit.dart';
import 'package:pet_share/models/address.dart';
import 'package:pet_share/models/adopter.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/models/applications.dart';
import 'package:pet_share/models/pet.dart';
import 'package:pet_share/models/shelter.dart';
import 'package:pet_share/models/user_info.dart';
import 'package:pet_share/services/auth_services.dart';
import 'package:pet_share/services/data_services.dart';

class MockAuthService extends Mock implements AuthService {}

class MockDataService extends Mock implements DataServices2 {}

class CubitReactionException implements Exception {}

void main() {
  late MockAuthService mockAuthService;
  late MockDataService mockDataService;
  late AppCubit appCubit;

  setUp(() {
    mockAuthService = MockAuthService();
    mockDataService = MockDataService();
    appCubit = AppCubit(
      mockDataService,
      mockAuthService,
      reaction: (_) {
        throw CubitReactionException();
      },
    );
  });

  group(
    'authUser()',
    () {
      blocTest(
        'successfuly authenticates user',
        setUp: () {
          when(() => mockAuthService.authApp())
              .thenAnswer((_) => Future.value(true));
          when(() => mockAuthService.selectAuthFlow(
                initAdopter: appCubit.initAdopter,
                initShelter: appCubit.initShelter,
                initUnassigned: appCubit.initUnassigned,
              )).thenAnswer((_) => Future.value());
        },
        build: () => appCubit,
        act: (cubit) => cubit.authUser(),
        verify: (_) {
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
              .thenAnswer((_) => Future.value(false));
        },
        build: () => appCubit,
        act: (cubit) => cubit.authUser(),
        verify: (_) {
          verify(() => mockAuthService.authApp()).called(1);
          verifyNever(() => mockAuthService.selectAuthFlow(
                initAdopter: appCubit.initAdopter,
                initShelter: appCubit.initShelter,
                initUnassigned: appCubit.initUnassigned,
              ));
        },
      );

      blocTest(
        'catches WebAuthenticationException exception and reacts',
        setUp: () {
          when(() => mockAuthService.authApp()).thenThrow(
            const WebAuthenticationException(
                'exceptionCode', 'exceptionMessage', {}),
          );
        },
        build: () => appCubit,
        act: (cubit) => cubit.authUser(),
        errors: () => [
          isA<CubitReactionException>(),
        ],
        verify: (_) {
          verify(() => mockAuthService.clearSettings()).called(1);
        },
      );

      blocTest(
        'catches WebAuthenticationException exception and doesn\'t react',
        setUp: () {
          when(() => mockAuthService.authApp()).thenThrow(
            const WebAuthenticationException(
              'a0.authentication_canceled',
              'exceptionMessage',
              {},
            ),
          );
        },
        build: () => appCubit,
        act: (cubit) => cubit.authUser(),
        errors: () => [],
        verify: (_) {
          verify(() => mockAuthService.clearSettings()).called(1);
        },
      );

      blocTest(
        'catches AuthServicesException',
        setUp: () {
          when(() => mockAuthService.authApp()).thenThrow(
            AuthServicesException('exceptionMessage'),
          );
        },
        build: () => appCubit,
        act: (cubit) => cubit.authUser(),
        errors: () => [
          isA<CubitReactionException>(),
        ],
        verify: (_) {
          verify(() => mockAuthService.clearAll()).called(1);
        },
      );
    },
  );

  group(
    'logoutUser()',
    () {
      blocTest(
        'successfuly logs user out',
        setUp: () {
          when(() => mockAuthService.logoutUser())
              .thenAnswer((_) => Future.value());
        },
        build: () => appCubit,
        act: (cubit) => cubit.logoutUser(),
        expect: () => [
          isA<AppSLoading>(),
          isA<AppSInitial>(),
        ],
        verify: (_) {
          verify(() => mockAuthService.logoutUser()).called(1);
        },
      );

      blocTest(
        'catches DataServicesException',
        setUp: () {
          when(() => mockAuthService.logoutUser())
              .thenThrow(DataServicesException('exceptionMessage'));
        },
        build: () => appCubit,
        act: (cubit) => cubit.logoutUser(),
        expect: () => [
          isA<AppSLoading>(),
        ],
        errors: () => [
          isA<CubitReactionException>(),
        ],
        verify: (_) {
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
        'successfuly sets adopter',
        setUp: () {
          when(() => mockDataService.postAdopter(adopter, token))
              .thenAnswer((_) => Future.value(idUser));
          when(() => mockAuthService.setRole(UserRoles.adopter, idUser))
              .thenAnswer((_) => Future.value());
          when(() => mockDataService.getAnnouncements(token))
              .thenAnswer((_) => Future.value([]));
          when(() => mockAuthService.accessToken).thenReturn(token);
          when(() => mockAuthService.userInfo).thenReturn(
            UserInfo(
                role: UserRoles.unknown,
                nickname: 'nickname',
                accessToken: token),
          );
        },
        build: () => appCubit,
        act: (cubit) => cubit.setAddopter(adopter),
        expect: () => [
          isA<AppSLoading>(),
          isA<AppSLoaded>(),
        ],
        verify: (_) {
          verify(() => mockDataService.postAdopter(adopter, token)).called(1);
          verify(() => mockAuthService.setRole(UserRoles.adopter, idUser))
              .called(1);
        },
      );

      blocTest(
        'catches DataServicesUnloggedException',
        setUp: () {
          when(() => mockDataService.postAdopter(adopter, token))
              .thenThrow(DataServicesUnloggedException('exceptionMessage'));
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.setAddopter(adopter),
        expect: () => [
          isA<AppSLoading>(),
          isA<AppSAuthed>(),
        ],
        errors: () => [
          isA<CubitReactionException>(),
        ],
        verify: (cubit) {
          verify(() => mockDataService.postAdopter(adopter, token)).called(1);
          verifyNever(() => mockAuthService.setRole(UserRoles.adopter, idUser));
        },
      );

      blocTest(
        'catches AuthServicesException',
        setUp: () {
          when(() => mockDataService.postAdopter(adopter, token))
              .thenThrow(AuthServicesException('exceptionMessage'));
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.setAddopter(adopter),
        expect: () => [
          isA<AppSLoading>(),
          isA<AppSAuthed>(),
        ],
        errors: () => [
          isA<CubitReactionException>(),
        ],
        verify: (cubit) {
          verify(() => mockDataService.postAdopter(adopter, token)).called(1);
          verifyNever(() => mockAuthService.setRole(UserRoles.adopter, idUser));
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
        'successfuly sets shelter',
        setUp: () {
          when(() => mockDataService.postShelter(shelter, token))
              .thenAnswer((_) => Future.value(idUser));
          when(() => mockAuthService.setRole(UserRoles.shelter, idUser))
              .thenAnswer((_) => Future.value());
          when(() => mockDataService.getShelterAnnouncements(token))
              .thenAnswer((_) => Future.value([]));
          when(() => mockDataService.getApplications(token))
              .thenAnswer((_) => Future.value([]));
          when(() => mockDataService.getShelterPets(token))
              .thenAnswer((_) => Future.value([]));
          when(() => mockAuthService.accessToken).thenReturn(token);
          when(() => mockAuthService.userInfo).thenReturn(
            UserInfo(
                role: UserRoles.unknown,
                nickname: 'nickname',
                accessToken: token),
          );
        },
        build: () => appCubit,
        act: (cubit) => cubit.setShelter(shelter),
        expect: () => [
          isA<AppSLoading>(),
          isA<AppSLoaded>(),
        ],
        verify: (_) {
          verify(() => mockDataService.postShelter(shelter, token)).called(1);
          verify(() => mockAuthService.setRole(UserRoles.shelter, idUser))
              .called(1);
        },
      );

      blocTest(
        'catches DataServicesUnloggedException',
        setUp: () {
          when(() => mockDataService.postShelter(shelter, token))
              .thenThrow(DataServicesUnloggedException('exceptionMessage'));
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.setShelter(shelter),
        expect: () => [
          isA<AppSLoading>(),
          isA<AppSAuthed>(),
        ],
        errors: () => [
          isA<CubitReactionException>(),
        ],
        verify: (_) {
          verify(() => mockDataService.postShelter(shelter, token)).called(1);
          verifyNever(() => mockAuthService.setRole(UserRoles.adopter, idUser));
        },
      );

      blocTest(
        'catches AuthServicesException',
        setUp: () {
          when(() => mockDataService.postShelter(shelter, token))
              .thenThrow(AuthServicesException('exceptionMessage'));
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.setShelter(shelter),
        expect: () => [
          isA<AppSLoading>(),
          isA<AppSAuthed>(),
        ],
        errors: () => [
          isA<CubitReactionException>(),
        ],
        verify: (_) {
          verify(() => mockDataService.postShelter(shelter, token)).called(1);
          verifyNever(() => mockAuthService.setRole(UserRoles.adopter, idUser));
        },
      );
    },
  );

  group(
    'initShelter()',
    () {
      String token = 'token';

      blocTest(
        'successfuly inits shelter',
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
        verify: (_) {
          verify(() => mockDataService.getShelterAnnouncements(token))
              .called(1);
          verify(() => mockDataService.getApplications(token)).called(1);
          verify(() => mockDataService.getShelterPets(token)).called(1);
        },
      );

      blocTest(
        'catches DataServicesLoggedException',
        setUp: () {
          when(() => mockDataService.getShelterAnnouncements(token))
              .thenThrow(DataServicesLoggedException('exceptionMessage'));
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.initShelter(),
        expect: () => [
          isA<AppSLoading>(),
          isA<AppSInitial>(),
        ],
        errors: () => [
          isA<CubitReactionException>(),
        ],
        verify: (_) {
          verify(() => mockDataService.getShelterAnnouncements(token))
              .called(1);
          verifyNever(() => mockDataService.getApplications(token));
          verifyNever(() => mockDataService.getShelterPets(token));
          verify(() => mockAuthService.clearAll()).called(1);
        },
      );
    },
  );

  group(
    'initAdopter()',
    () {
      String token = 'token';

      blocTest(
        'successfuly inits adopter',
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
        verify: (_) {
          verify(() => mockDataService.getAnnouncements(token)).called(1);
        },
      );

      blocTest(
        'catches DataServicesLoggedException',
        setUp: () {
          when(() => mockDataService.getAnnouncements(token))
              .thenThrow(DataServicesLoggedException('exceptionMessage'));
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.initAdopter(),
        expect: () => [
          isA<AppSLoading>(),
          isA<AppSInitial>(),
        ],
        errors: () => [
          isA<CubitReactionException>(),
        ],
        verify: (_) {
          verify(() => mockDataService.getAnnouncements(token)).called(1);
          verify(() => mockAuthService.clearAll()).called(1);
        },
      );
    },
  );

  group(
    'initUnassigned()',
    () {
      blocTest(
        'successfuly inits unassigned',
        build: () => appCubit,
        act: (cubit) => cubit.initUnassigned(),
        expect: () => [
          isA<AppSAuthed>(),
        ],
      );
    },
  );

  // group(
  //   'refreshPets()',
  //   () {
  //     String token = 'token';

  //     blocTest(
  //       'refreshes pets',
  //       setUp: () {
  //         appCubit.emit(
  //           AppSLoaded(
  //             announcements: const [],
  //             applications: const [],
  //             pets: const [],
  //             userInfo: UserInfo(
  //                 role: UserRoles.unknown,
  //                 nickname: 'nickname',
  //                 accessToken: token),
  //           ),
  //         );

  //         when(() => mockDataService.getShelterPets(token))
  //             .thenAnswer((invocation) => Future.value(mockPets));
  //         when(() => mockAuthService.accessToken).thenReturn(token);
  //       },
  //       build: () => appCubit,
  //       act: (cubit) => cubit.refreshPets(),
  //       expect: () => [
  //         isA<AppSRefreshing>(),
  //         isA<AppSLoaded>(),
  //       ],
  //       verify: (cubit) {
  //         verify(() => mockDataService.getShelterPets(token)).called(1);

  //         expect((cubit.state as AppSLoaded).pets, mockPets);
  //       },
  //     );

  //     blocTest(
  //       'does nothing',
  //       setUp: () {},
  //       build: () => appCubit,
  //       act: (cubit) => cubit.refreshPets(),
  //       expect: () => [],
  //       verify: (_) {
  //         verifyNever(() => mockDataService.getShelterPets(token));
  //       },
  //     );

  //     blocTest(
  //       'catches DataServicesLoggedException',
  //       setUp: () {
  //         appCubit.emit(
  //           AppSLoaded(
  //             announcements: const [],
  //             applications: const [],
  //             pets: const [],
  //             userInfo: UserInfo(
  //                 role: UserRoles.unknown,
  //                 nickname: 'nickname',
  //                 accessToken: token),
  //           ),
  //         );

  //         when(() => mockDataService.getShelterPets(token))
  //             .thenThrow(DataServicesLoggedException('exceptionMessage'));
  //         when(() => mockAuthService.accessToken).thenReturn(token);
  //       },
  //       build: () => appCubit,
  //       act: (cubit) => cubit.refreshPets(),
  //       expect: () => [
  //         isA<AppSRefreshing>(),
  //         isA<AppSLoaded>(),
  //       ],
  //       errors: () => [
  //         isA<CubitReactionException>(),
  //       ],
  //       verify: (_) {
  //         verify(() => mockDataService.getShelterPets(token)).called(1);
  //       },
  //     );
  //   },
  // );

  // group(
  //   'refreshAnnouncements()',
  //   () {
  //     String token = 'token';

  //     blocTest(
  //       'refreshes announcements if user role is adopter',
  //       setUp: () {
  //         appCubit.emit(
  //           AppSLoaded(
  //             announcements: const [],
  //             applications: const [],
  //             pets: const [],
  //             userInfo: UserInfo(
  //                 role: UserRoles.adopter,
  //                 nickname: 'nickname',
  //                 accessToken: token),
  //           ),
  //         );

  //         when(() => mockDataService.getAnnouncements(token))
  //             .thenAnswer((invocation) => Future.value(mockAnnouncements));
  //         when(() => mockAuthService.accessToken).thenReturn(token);
  //       },
  //       build: () => appCubit,
  //       act: (cubit) => cubit.refreshAnnouncements(),
  //       expect: () => [
  //         isA<AppSRefreshing>(),
  //         isA<AppSLoaded>(),
  //       ],
  //       verify: (cubit) {
  //         verify(() => mockDataService.getAnnouncements(token)).called(1);

  //         expect((cubit.state as AppSLoaded).announcements, mockAnnouncements);
  //       },
  //     );

  //     blocTest(
  //       'refreshes announcements if user role is other than adopter',
  //       setUp: () {
  //         appCubit.emit(
  //           AppSLoaded(
  //             announcements: const [],
  //             applications: const [],
  //             pets: const [],
  //             userInfo: UserInfo(
  //                 role: UserRoles.unknown,
  //                 nickname: 'nickname',
  //                 accessToken: token),
  //           ),
  //         );

  //         when(() => mockDataService.getShelterAnnouncements(token))
  //             .thenAnswer((invocation) => Future.value(mockAnnouncements));
  //         when(() => mockAuthService.accessToken).thenReturn(token);
  //       },
  //       build: () => appCubit,
  //       act: (cubit) => cubit.refreshAnnouncements(),
  //       expect: () => [
  //         isA<AppSRefreshing>(),
  //         isA<AppSLoaded>(),
  //       ],
  //       verify: (cubit) {
  //         verify(() => mockDataService.getShelterAnnouncements(token))
  //             .called(1);

  //         expect((cubit.state as AppSLoaded).announcements, mockAnnouncements);
  //       },
  //     );

  //     blocTest(
  //       'does nothing',
  //       setUp: () {},
  //       build: () => appCubit,
  //       act: (cubit) => cubit.refreshAnnouncements(),
  //       expect: () => [],
  //       verify: (_) {
  //         verifyNever(() => mockDataService.getAnnouncements(token));
  //         verifyNever(() => mockDataService.getShelterAnnouncements(token));
  //       },
  //     );

  //     blocTest(
  //       'catches DataServicesLoggedException if user role is adopter',
  //       setUp: () {
  //         appCubit.emit(
  //           AppSLoaded(
  //             announcements: const [],
  //             applications: const [],
  //             pets: const [],
  //             userInfo: UserInfo(
  //                 role: UserRoles.adopter,
  //                 nickname: 'nickname',
  //                 accessToken: token),
  //           ),
  //         );

  //         when(() => mockDataService.getAnnouncements(token))
  //             .thenThrow(DataServicesLoggedException('exceptionMessage'));
  //         when(() => mockAuthService.accessToken).thenReturn(token);
  //       },
  //       build: () => appCubit,
  //       act: (cubit) => cubit.refreshAnnouncements(),
  //       expect: () => [
  //         isA<AppSRefreshing>(),
  //         isA<AppSLoaded>(),
  //       ],
  //       errors: () => [
  //         isA<CubitReactionException>(),
  //       ],
  //       verify: (cubit) {
  //         verify(() => mockDataService.getAnnouncements(token)).called(1);
  //       },
  //     );

  //     blocTest(
  //       'catches DataServicesLoggedException if user role other than adopter',
  //       setUp: () {
  //         appCubit.emit(
  //           AppSLoaded(
  //             announcements: const [],
  //             applications: const [],
  //             pets: const [],
  //             userInfo: UserInfo(
  //                 role: UserRoles.unknown,
  //                 nickname: 'nickname',
  //                 accessToken: token),
  //           ),
  //         );

  //         when(() => mockDataService.getShelterAnnouncements(token))
  //             .thenThrow(DataServicesLoggedException('exceptionMessage'));
  //         when(() => mockAuthService.accessToken).thenReturn(token);
  //       },
  //       build: () => appCubit,
  //       act: (cubit) => cubit.refreshAnnouncements(),
  //       expect: () => [
  //         isA<AppSRefreshing>(),
  //         isA<AppSLoaded>(),
  //       ],
  //       errors: () => [
  //         isA<CubitReactionException>(),
  //       ],
  //       verify: (_) {
  //         verify(() => mockDataService.getShelterAnnouncements(token))
  //             .called(1);
  //       },
  //     );
  //   },
  // );

  // group(
  //   'refreshApplications()',
  //   () {
  //     String token = 'token';

  //     blocTest(
  //       'refreshes applications',
  //       setUp: () {
  //         appCubit.emit(
  //           AppSLoaded(
  //             announcements: const [],
  //             applications: const [],
  //             pets: const [],
  //             userInfo: UserInfo(
  //                 role: UserRoles.unknown,
  //                 nickname: 'nickname',
  //                 accessToken: token),
  //           ),
  //         );

  //         when(() => mockDataService.getApplications(token))
  //             .thenAnswer((invocation) => Future.value(mockApplications));
  //         when(() => mockAuthService.accessToken).thenReturn(token);
  //       },
  //       build: () => appCubit,
  //       act: (cubit) => cubit.refreshApplications(),
  //       expect: () => [
  //         isA<AppSRefreshing>(),
  //         isA<AppSLoaded>(),
  //       ],
  //       verify: (cubit) {
  //         verify(() => mockDataService.getApplications(token)).called(1);

  //         expect((cubit.state as AppSLoaded).applications, mockApplications);
  //       },
  //     );

  //     blocTest(
  //       'does nothing',
  //       setUp: () {},
  //       build: () => appCubit,
  //       act: (cubit) => cubit.refreshApplications(),
  //       expect: () => [],
  //       verify: (_) {
  //         verifyNever(() => mockDataService.getApplications(token));
  //       },
  //     );

  //     blocTest(
  //       'catches DataServicesLoggedException',
  //       setUp: () {
  //         appCubit.emit(
  //           AppSLoaded(
  //             announcements: const [],
  //             applications: const [],
  //             pets: const [],
  //             userInfo: UserInfo(
  //                 role: UserRoles.unknown,
  //                 nickname: 'nickname',
  //                 accessToken: token),
  //           ),
  //         );

  //         when(() => mockDataService.getApplications(token))
  //             .thenThrow(DataServicesLoggedException('exceptionMessage'));
  //         when(() => mockAuthService.accessToken).thenReturn(token);
  //       },
  //       build: () => appCubit,
  //       act: (cubit) => cubit.refreshApplications(),
  //       expect: () => [
  //         isA<AppSRefreshing>(),
  //         isA<AppSLoaded>(),
  //       ],
  //       errors: () => [
  //         isA<CubitReactionException>(),
  //       ],
  //       verify: (_) {
  //         verify(() => mockDataService.getApplications(token)).called(1);
  //       },
  //     );
  //   },
  // );

  group(
    'addPet()',
    () {
      CreatingPet2 pet = MockCreatingPet();
      String token = 'token';

      blocTest(
        'adds pet',
        setUp: () {
          when(() => mockDataService.postPet(token, pet))
              .thenAnswer((_) => Future.value());
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.addPet(pet),
        verify: (_) {
          verify(() => mockDataService.postPet(token, pet)).called(1);
        },
      );

      blocTest(
        'catches DataServicesLoggedException',
        setUp: () {
          when(() => mockDataService.postPet(token, pet))
              .thenThrow(DataServicesLoggedException('exceptionMessage'));
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.addPet(pet),
        errors: () => [
          isA<CubitReactionException>(),
        ],
        verify: (_) {
          verify(() => mockDataService.postPet(token, pet)).called(1);
        },
      );
    },
  );

  group(
    'addAnnouncement()',
    () {
      CreatingAnnouncement2 announcement = MockCreatingAnnouncement();
      String token = 'token';

      blocTest(
        'adds announcement',
        setUp: () {
          when(() => mockDataService.postAnnouncement(token, announcement))
              .thenAnswer((_) => Future.value());
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.addAnnouncement(announcement),
        verify: (_) {
          verify(() => mockDataService.postAnnouncement(token, announcement))
              .called(1);
        },
      );

      blocTest(
        'catches DataServicesLoggedException',
        setUp: () {
          when(() => mockDataService.postAnnouncement(token, announcement))
              .thenThrow(DataServicesLoggedException('exceptionMessage'));
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.addAnnouncement(announcement),
        errors: () => [
          isA<CubitReactionException>(),
        ],
        verify: (_) {
          verify(() => mockDataService.postAnnouncement(token, announcement))
              .called(1);
        },
      );
    },
  );

  group(
    'addApplication()',
    () {
      String announcementId = 'id';
      String token = 'token';
      UserInfo userInfo = UserInfo(
        role: UserRoles.unknown,
        nickname: 'nickname',
        accessToken: token,
        id: 'id',
      );

      blocTest(
        'adds application',
        setUp: () {
          when(() => mockDataService.postApplication(
                token,
                announcementId,
                userInfo.id,
              )).thenAnswer((_) => Future.value());
          when(() => mockAuthService.accessToken).thenReturn(token);
          when(() => mockAuthService.userInfo).thenReturn(userInfo);
        },
        build: () => appCubit,
        act: (cubit) => cubit.addApplication(announcementId),
        verify: (_) {
          verify(() => mockDataService.postApplication(
              token, announcementId, userInfo.id)).called(1);
        },
      );

      blocTest(
        'catches DataServicesLoggedException',
        setUp: () {
          when(() => mockDataService.postApplication(
                token,
                announcementId,
                userInfo.id,
              )).thenThrow(DataServicesLoggedException('exceptionMessage'));
          when(() => mockAuthService.accessToken).thenReturn(token);
          when(() => mockAuthService.userInfo).thenReturn(userInfo);
        },
        build: () => appCubit,
        act: (cubit) => cubit.addApplication(announcementId),
        errors: () => [
          isA<CubitReactionException>(),
        ],
        verify: (_) {
          verify(() => mockDataService.postApplication(
              token, announcementId, userInfo.id)).called(1);
        },
      );
    },
  );

  group(
    'acceptApplication()',
    () {
      String applicationId = 'id';
      String token = 'token';

      blocTest(
        'accepts application',
        setUp: () {
          when(() => mockDataService.putAcceptApplication(token, applicationId))
              .thenAnswer((_) => Future.value());
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.acceptApplication(applicationId),
        verify: (_) {
          verify(() => mockDataService.putAcceptApplication(
                token,
                applicationId,
              )).called(1);
        },
      );

      blocTest(
        'catches DataServicesLoggedException',
        setUp: () {
          when(() => mockDataService.putAcceptApplication(token, applicationId))
              .thenThrow(DataServicesLoggedException('exceptionMessage'));
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.acceptApplication(applicationId),
        errors: () => [
          isA<CubitReactionException>(),
        ],
        verify: (_) {
          verify(() => mockDataService.putAcceptApplication(
                token,
                applicationId,
              )).called(1);
        },
      );
    },
  );

  group(
    'rejectApplication()',
    () {
      String applicationId = 'id';
      String token = 'token';

      blocTest(
        'rejects application',
        setUp: () {
          when(() => mockDataService.putRejectApplication(token, applicationId))
              .thenAnswer((_) => Future.value());
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.rejectApplication(applicationId),
        verify: (_) {
          verify(() => mockDataService.putRejectApplication(
                token,
                applicationId,
              )).called(1);
        },
      );

      blocTest(
        'catches DataServicesLoggedException',
        setUp: () {
          when(() => mockDataService.putRejectApplication(token, applicationId))
              .thenThrow(DataServicesLoggedException('exceptionMessage'));
          when(() => mockAuthService.accessToken).thenReturn(token);
        },
        build: () => appCubit,
        act: (cubit) => cubit.rejectApplication(applicationId),
        errors: () => [
          isA<CubitReactionException>(),
        ],
        verify: (_) {
          verify(() => mockDataService.putRejectApplication(
                token,
                applicationId,
              )).called(1);
        },
      );
    },
  );
}

class MockPet extends Mock implements Pet2 {}

List<Pet2> mockPets = [
  MockPet(),
  MockPet(),
];

class MockAnnouncement extends Mock implements Announcement2 {}

List<Announcement2> mockAnnouncements = [
  MockAnnouncement(),
  MockAnnouncement(),
];

class MockApplication extends Mock implements Appplications2 {}

List<Appplications2> mockApplications = [
  MockApplication(),
  MockApplication(),
];

class MockCreatingPet extends Mock implements CreatingPet2 {}

class MockCreatingAnnouncement extends Mock implements CreatingAnnouncement2 {}
