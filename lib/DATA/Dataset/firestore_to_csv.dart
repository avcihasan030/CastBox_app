import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<void> exportFirestoreDataToCsv() async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('playlists').get();

    List<List<dynamic>> csvData = [];

    csvData.add(['ID', 'Name', 'Description', 'CategoryId', 'CategoryName']);

    /// Firestore'dan alınan verileri CSV veri yapısına dönüştür
    querySnapshot.docs.forEach((doc) async {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<dynamic> row = [
        data['id'],
        data['name'],
        data['description'],
        data['categoryId'],
      ];
      csvData.add(row);
    });

    /// CSV dosyasını oluştur ve verileri yaz
    String csv = const ListToCsvConverter().convert(csvData);
    String csvFileName = 'exported_data.csv';
    String csvPath =
        '${(await getExternalStorageDirectory())!.path}/$csvFileName';
    File csvFile = File(csvPath);
    await csvFile.writeAsString(csv);

    print("Veriler CSV dosyasına aktarıldı: $csvPath");
  } catch (e) {
    print("Firestore veri aktarımında bir hata oluştu: $e");
  }
}
