import 'package:flutter_test/flutter_test.dart';
import 'package:pet_share/cubits/appCubit/app_cubit.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/models/pet.dart';
import 'package:pet_share/models/user_info.dart';
import 'package:pet_share/services/auth_services.dart';

void main() {
  group(
    'AppState',
    () {
      test('initial state should have empty props', () {
        expect(AppSInitial().props, []);
      });
      test('authed state should have empty props', () {
        expect(AppSAuthed().props, []);
      });
      test('loading state should have empty props', () {
        expect(AppSLoading().props, []);
      });
      test('loaded state should have correct props', () {
        final announcements = <Announcement>[
          Announcement(
            id: '1',
            title: 'Title 1',
            description: 'Description 1',
            creationDate: DateTime.now(),
            closingDate: null,
            lastUpdateDate: DateTime.now(),
            status: 1,
            pet: Pet(
                id: 'id',
                shelterID: 'shelterID',
                name: 'name',
                species: 'species',
                breed: 'breed',
                birthday: DateTime.now(),
                description: 'description',
                photo: <int>[]),
            author: Author(
              id: '1',
              userName: 'User 1',
              phoneNumer: '1234567890',
              email: 'user1@example.com',
              fullShelterName: null,
              isAuthorized: false,
              adress: null,
            ),
          ),
        ];

        final userInfo = UserInfo(
          role: UserRoles.adopter,
          nickname: 'Admin',
          accessToken: '1234567890',
        );

        final state = AppSLoaded(
          announcements: announcements,
          userInfo: userInfo,
        );

        expect(state.props, [announcements, userInfo]);
      });
    },
  );
}
