import 'package:final_year_project/DATA/API/Database_Services/recommendation_revice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Recommendations extends ConsumerWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Favori şarkıları temsil eden örnek veri
            Map<String, dynamic> favoriteSong = {'name': 'Bird Stealing Bread'};

            // API'ye istek gönder ve önerileri al
            Map<String, dynamic> recommendations =
                await apiService.fetchRecommendations(favoriteSong);
            if (recommendations != null) {
              // Önerileri işle ve kullan
              print('Öneriler: $recommendations');
            } else {
              // Kullanıcıya hata mesajı göster veya uygun bir geri bildirim sağla
              print('Öneri alınamadı. Lütfen daha sonra tekrar deneyin.');
            }
          },
          child: Text('API İsteği Yap'),
        ),
      ),
    );
  }
}
