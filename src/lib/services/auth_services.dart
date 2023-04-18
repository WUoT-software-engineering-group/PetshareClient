import 'dart:convert';
import 'dart:developer';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:http/http.dart' as http;

const auth0Domain = 'dev-siwe-sowy.eu.auth0.com';
const auth0ClientId = 'jCSWViMQ2bZpZDJvzFBb2zkpOCz1NP92';
const auth0ClientSecret =
    '1UpSOpSFaK5rHvdy88pvbiMHSGW07toKB5-JeDZLsZoVfjUpYrxcad4m6NJdZ_lk';
const auth0Audience = 'https://pet-share-web-api-dev.azurewebsites.net/';
const auth0AudienceManagementAPI = 'https://dev-siwe-sowy.eu.auth0.com/api/v2/';
const auth0Scheme = 'https';

enum UserRoles {
  unassigned,
  adopter,
  shelter,
  unknown,
}

class AuthService {
  late Auth0 auth0;
  Credentials? _credentials;
  UserRoles? role;
  String? nickname;
  String? accessToken;

  AuthService() {
    auth0 = Auth0(auth0Domain, auth0ClientId);
  }

  /// ----------------------------------
  /// authenticatons methods
  /// ----------------------------------

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

  void _setLocalVariables() {
    if (_credentials != null) {
      nickname = parseIdToken(_credentials!.idToken)['nickname'];
      role = _stringToRole(parseAccessToken(_credentials!.accessToken)['role']);
      accessToken = _credentials!.accessToken;
    } else {
      nickname = accessToken = role = null;
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
      );
      _credentials = credentials;
      _setLocalVariables();
    }

    return _credentials != null;
  }

  /// ----------------------------------
  /// seting roles
  /// ----------------------------------

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
      throw Exception(
          'AuthServices: setRole: cannot get access token to Management API!');
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
      throw Exception('AuthServices: setRole: cannot patch role!');
    }

    log('AuthServices: setRole: The role ${_roleToString(userRoles)} was set correctly.');
  }

  /// ----------------------------------
  /// get info methos
  /// ----------------------------------

  String getEmail() {
    if (_credentials != null) {
      return parseIdToken(_credentials!.idToken)['email'];
    }
    return '';
  }

  /// ----------------------------------
  /// static methods
  /// ----------------------------------

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
      throw const FormatException('Invalid token');
    }
    try {
      final accessTokenBase64 = splitToken[1];
      final accessTokenPayload = base64.normalize(accessTokenBase64);
      final accessTokenString = utf8.decode(base64.decode(accessTokenPayload));
      final accessTokenMap = jsonDecode(accessTokenString);
      return accessTokenMap;
    } catch (error) {
      throw const FormatException('Invalid payload');
    }
  }
}
