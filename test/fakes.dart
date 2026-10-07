import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tonits/features/auth/token_store.dart';

class MemoryTokenStore implements TokenStore {
  MemoryTokenStore([this.token]);

  String? token;

  @override
  Future<String?> readRefreshToken() async => token;

  @override
  Future<void> writeRefreshToken(String value) async => token = value;

  @override
  Future<void> clear() async => token = null;
}

http.Response jsonResponse(
  Object body,
  int status, {
  Map<String, String>? headers,
}) => http.Response(
  jsonEncode(body),
  status,
  headers: {'content-type': 'application/json', ...?headers},
);

http.Response errorResponse(
  int status,
  String code, {
  Map<String, String>? headers,
}) => jsonResponse(
  {'error': code, 'message': 'Server says $code'},
  status,
  headers: headers,
);

Map<String, dynamic> playerJson({String countryCode = 'KE'}) => {
  'id': '6f1c2c55-0d3e-4b9b-9a55-0c0b8a3e1d11',
  'username': 'striker.9',
  'konamiId': 'ABCD-1234-EFGH',
  'displayName': 'striker.9',
  'email': null,
  'emailVerified': false,
  'phoneNumber': null,
  'countryCode': countryCode,
  'birthDate': null,
  'status': 'active',
  'profile': null,
};

Map<String, dynamic> sessionJson({
  String access = 'access-1',
  String refresh = 'refresh-1',
}) => {
  'accessToken': access,
  'refreshToken': refresh,
  'tokenType': 'Bearer',
  'expiresInSeconds': 900,
  'player': playerJson(),
};
