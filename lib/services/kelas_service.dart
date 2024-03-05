import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import '../common/theme.dart';
import '../models/kelas_model.dart';

class KelasService {
  AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }
  
  Future<List<KelasModel>> getkelas() async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String apiURL = "${baseAPIURL()}/guru-kelas";
    String? token = await storage.read(key: "token");
    // print(apiURL);

    try {
      var response = await get(
        Uri.parse(apiURL),
        headers: header(
          true,
          token: token,
        ),
      );

      if (response.statusCode == 200) {
        final kelas = jsonDecode(response.body)['data'] as List;

        // print(kelas);
        final kelass = kelas.map((object) {
          return KelasModel(
            id: object['id'] ?? 0,
            sekolahId: object['kelas_id'] ?? 0,
            kelas: object['kelas'] ?? "",
            createdAt: object['created_at'] ?? "",
            updatedAt: object['updated_at'] ?? "",
          );
        }).toList();

        return kelass;
      } else {
        // final kelas = jsonDecode(response.body)['data'] as List;
        // print(kelas);
        return [];
      }
    } catch (e) {
      // print(e);
      throw Exception("Get kelas gagal.\nError: $e");
    }
  }
}
