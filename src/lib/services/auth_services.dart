import 'dart:convert';
import 'dart:developer';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pet_share/models/user_info.dart';
import 'dart:io' show Platform;

const auth0Domain = 'dev-siwe-sowy.eu.auth0.com';
const auth0ClientId = 'jCSWViMQ2bZpZDJvzFBb2zkpOCz1NP92';
const auth0ClientSecret =
    '1UpSOpSFaK5rHvdy88pvbiMHSGW07toKB5-JeDZLsZoVfjUpYrxcad4m6NJdZ_lk';
const auth0Audience = 'https://pet-share-web-api-dev.azurewebsites.net/';
const auth0AudienceManagementAPI = 'https://dev-siwe-sowy.eu.auth0.com/api/v2/';
const auth0Scheme = 'https';
String auth0redirectUrl = Platform.isIOS
    ? 'com.petshare://dev-siwe-sowy.eu.auth0.com/ios/com.petshare/callback'
    : 'https://dev-siwe-sowy.eu.auth0.com/android/com.example.pet_share/callback';

enum UserRoles {
  unassigned,
  adopter,
  shelter,
  unknown,
}

class AuthService {
  late Auth0 auth0;
  Credentials? _credentials;
  late UserInfo _userInfo;

  // ----------------------------------
  // Gets & Sets
  // ----------------------------------

  UserRoles get role => _userInfo.role;
  String get nickname => _userInfo.nickname;
  String get accessToken => _userInfo.accessToken;
  UserInfo get userInfo => _userInfo;

  String get getEmail {
    if (_credentials != null) {
      return parseIdToken(_credentials!.idToken)['email'];
    }
    return '';
  }

  // ----------------------------------
  // Contstructors
  // ----------------------------------

  AuthService() {
    auth0 = Auth0(auth0Domain, auth0ClientId);
  }

  // ----------------------------------
  // Authenticatons methods
  // ----------------------------------

  void _setLocalVariables(UserRoles userRoles, String? id) {
    try {
      final String nickname = parseIdToken(_credentials!.idToken)['nickname'];

      // creating userInfo for the whole app
      _userInfo = UserInfo(
        role: userRoles,
        nickname: nickname,
        accessToken: _credentials!.accessToken,
        id: id ?? '',
      );
    } catch (e) {
      log('AuthService: _setLocalVariables: something goes wrong with credentials!');
      rethrow;
    }
  }

  Future<bool> authApp() async {
    if (_credentials == null) {
      final credentials = await auth0.webAuthentication().login(
          audience: auth0Audience,
          scopes: {
            'openid',
            'profile',
            'email',
          },
          redirectUrl: auth0redirectUrl);
      _credentials = credentials;

      final userId = parseAccessToken(_credentials!.accessToken)['db_id'];
      final UserRoles roleUser =
          _stringToRole(parseAccessToken(_credentials!.accessToken)['role']);
      _setLocalVariables(roleUser, userId);
    }

    return _credentials != null;
  }

  Future<void> selectAuthFlow({
    required AsyncCallback initAdopter,
    required AsyncCallback initShelter,
    required AsyncCallback initUnassigned,
  }) async {
    switch (role) {
      case UserRoles.adopter:
        await initAdopter();
        break;
      case UserRoles.shelter:
        await initShelter();
        break;
      case UserRoles.unassigned:
        await initUnassigned();
        break;
      case UserRoles.unknown:
        log('AppCubit:authUser: unknown role of user');
        break;
      default:
        log('AppCubit: authUser: Somethings went wrong. Wrong role!');
    }
  }

  Future<void> logoutUser() async {
    await auth0.webAuthentication().logout();

    clearSettings();
    log('AuthServices: logoutUser: The user is logged out.');
  }

  // ----------------------------------
  // Seting roles
  // ----------------------------------

  Future<void> setRole(UserRoles userRoles, String idUser) async {
    // this is uri to Management API for access token
    // https://auth0.com/docs/secure/tokens/access-tokens/get-access-tokens#parameters
    Uri uriPostManagementAPI = Uri(
      scheme: auth0Scheme,
      host: auth0Domain,
      path: '/oauth/token',
    );

    var resultAccessTokenPost = await http.post(
      uriPostManagementAPI,
      headers: {
        'content-type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'client_credentials',
        'client_id': auth0ClientId,
        'client_secret': auth0ClientSecret,
        'audience': auth0AudienceManagementAPI
      },
    );

    if (resultAccessTokenPost.statusCode != 200) {
      log('AuthServices: setRole: cannot get access token to Management API!');
      throw AuthServicesException('Getting the access failed!');
    }

    Uri uriPatchUser = Uri(
      scheme: 'https',
      host: auth0Domain,
      path: '/api/v2/users/${parseIdToken(_credentials!.idToken)['sub']}',
    );

    var resultPatchUser = await http.patch(uriPatchUser,
        headers: {
          'Authorization':
              'Bearer ${getAccessTokenManagementAPI(resultAccessTokenPost.body)}',
          'content-type': 'application/json',
        },
        body: json.encode(
          {
            "app_metadata": {
              'role': _roleToString(userRoles),
              'db_id': idUser,
            }
          },
        ));

    if (resultPatchUser.statusCode != 200) {
      log('AuthServices: setRole: cannot patch role!');
      throw AuthServicesException('Setting the role failed!');
    }

    log('AuthServices: setRole: The role ${_roleToString(userRoles)} was set correctly.');
    _setLocalVariables(userRoles, idUser);
  }

  // ----------------------------------
  // General roles methods
  // ----------------------------------

  UserRoles _stringToRole(String roleString) {
    if (roleString == 'unassigned') {
      return UserRoles.unassigned;
    } else if (roleString == 'shelter') {
      return UserRoles.shelter;
    } else if (roleString == 'adopter') {
      return UserRoles.adopter;
    } else {
      return UserRoles.unknown;
    }
  }

  String _roleToString(UserRoles role) {
    switch (role) {
      case UserRoles.unassigned:
        return 'unassigned';
      case UserRoles.adopter:
        return 'adopter';
      case UserRoles.shelter:
        return 'shelter';
      case UserRoles.unknown:
        return 'unknown';
    }
  }

  void clearSettings() {
    _credentials = null;
    _userInfo = UserInfo(
      role: UserRoles.unknown,
      nickname: '',
      accessToken: '',
    );
  }

  void clearAll() {
    clearSettings();
    auth0 = Auth0(auth0Domain, auth0ClientId);
  }

  // ----------------------------------
  // Static methods
  // ----------------------------------

  static String getAccessTokenManagementAPI(String body) {
    final part = body
        .split(',')
        .firstWhere((element) => element.contains('access_token'));
    final pair = part.split(':');
    var tok = pair.firstWhere((element) => !element.contains('access_token'));
    return tok.replaceAll('"', "");
  }

  static Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');

    final Map<String, dynamic> json = jsonDecode(
      utf8.decode(
        base64Url.decode(
          base64Url.normalize(parts[1]),
        ),
      ),
    );

    return json;
  }

  static Map<String, dynamic> parseAccessToken(String accessToken) {
    final splitToken = accessToken.split(".");
    if (splitToken.length != 3) {
      log('Invalid token!');
      throw AuthServicesException('Bad authorisation!');
    }
    try {
      final accessTokenBase64 = splitToken[1];
      final accessTokenPayload = base64.normalize(accessTokenBase64);
      final accessTokenString = utf8.decode(base64.decode(accessTokenPayload));
      final accessTokenMap = jsonDecode(accessTokenString);
      return accessTokenMap;
    } catch (error) {
      log('Invalid payload');
      throw AuthServicesException('Bad authorisation!');
    }
  }
}

class AuthServicesException implements Exception {
  final String message;

  AuthServicesException(this.message);

  @override
  String toString() {
    return message;
  }
}
