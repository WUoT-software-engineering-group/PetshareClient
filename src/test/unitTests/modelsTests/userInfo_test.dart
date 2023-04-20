import 'package:flutter_test/flutter_test.dart';
import 'package:pet_share/models/user_info.dart';
import 'package:pet_share/services/auth_services.dart';

void main() {
  group('UserInfo', () {
    test('constructor should set the correct values', () {
      const role = UserRoles.adopter;
      const nickname = 'John';
      const accessToken = 'abc123';

      final userInfo =
          UserInfo(role: role, nickname: nickname, accessToken: accessToken);

      expect(userInfo.role, role);
      expect(userInfo.nickname, nickname);
      expect(userInfo.accessToken, accessToken);
    });

    test('getters should return the correct values', () {
      const role = UserRoles.adopter;
      const nickname = 'Jane';
      const accessToken = 'def456';
      final userInfo =
          UserInfo(role: role, nickname: nickname, accessToken: accessToken);

      expect(userInfo.role, role);
      expect(userInfo.nickname, nickname);
      expect(userInfo.accessToken, accessToken);
    });
  });
}
