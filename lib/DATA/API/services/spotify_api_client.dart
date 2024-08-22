import 'dart:convert';

import 'package:dio/dio.dart';

class SpotifyApiClient {
  final String clientId = 'YOUR_CLIENT_ID';
  final String clientSecret = 'YOUR_CLIENT_SECRET';
  final String tokenUrl = 'https://accounts.spotify.com/api/token';

  final Dio dio = Dio();

  Future<String> getAccessToken() async {
    try {
      final response = await dio.post(
        tokenUrl,
        options: Options(
          headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: {'grant_type': 'client_credentials'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final String accessToken = data['access_token'];
        return accessToken;
      } else {
        throw Exception("Failed to get access token");
      }
    } catch (error) {
      throw Exception("Error: $error");
    }
  }
}
