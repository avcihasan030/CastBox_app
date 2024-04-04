import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();
  final String apiUrl = 'http://127.0.0.1:8000/recommendations/';

  Future<Map<String, dynamic>> fetchRecommendations(
      Map<String, dynamic> favoriteSong) async {
    try {
      // API'ye POST isteği yap
      Response response = await dio.post(apiUrl, data: favoriteSong);
      // API'den gelen veriyi işle
      Map<String, dynamic> recommendations = response.data;
      return recommendations;
    } catch (error) {
      // Hata durumunda null değeri döndür
      print('Hata: $error');
    }
    return {};
  }
}
