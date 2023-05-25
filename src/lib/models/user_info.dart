import '../services/auth_services.dart';

class UserInfo {
  late UserRoles _role;
  late String _nickname;
  late String _accessToken;
  late String _id;

  // ----------------------------------
  // Gets & Sets
  // ----------------------------------

  UserRoles get role => _role;
  String get nickname => _nickname;
  String get accessToken => _accessToken;
  String get id => _id;

  // ----------------------------------
  // Contstructors $ Factories
  // ----------------------------------

  UserInfo({
    required UserRoles role,
    required String nickname,
    required String accessToken,
    String id = '', // <------ to trzeba naprawić
  }) {
    _role = role;
    _nickname = nickname;
    _accessToken = accessToken;
    _id = id;
  }
}
