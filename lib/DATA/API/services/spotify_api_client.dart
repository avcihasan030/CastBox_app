import 'dart:convert';

import 'package:dio/dio.dart';

class SpotifyApiClient {
  final String clientId = '655ce5da86534d18a90eccbbb36e4fda';
  final String clientSecret = 'b7e1d830062946558f1c2ddf9cabcb4a';
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
