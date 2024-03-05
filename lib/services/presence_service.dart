import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import '../common/theme.dart';
import '../models/presence_model.dart';

class PresenceService {
  AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }

  Future<List<PresenceModel>> getPresensi(String kelasId) async {
    String apiURL = "${baseAPIURL()}/guru-presensi/$kelasId";
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
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
        final presensi = jsonDecode(response.body)['data'] as List;

        // print(presensi);
        final presensis = presensi.map((object) {
          return PresenceModel(
            // id: int.parse(object['id'] ?? "0"),
            // name: object['name'] ?? "",
            // tipePresensi: object['tipe_presensi'] ?? "",
            // waktuMasuk: object['waktu_masuk'] ?? "",
            // waktuKeluar: object['waktu_keluar'] ?? "",
            // image: object['image'] ?? "",
            // statusVerifikasi: object['status_verifikasi'] ?? "",
            // siswaId: int.parse(object['siswa_id'] ?? "0"),
            // tipePresensiId: int.parse(object['tipe_presensi_id'] ?? "0"),
            // semesterId: int.parse(object['semester_id'] ?? "0"),
            // tahunAjaranId: int.parse(object['tahunAjaran_id'] ?? "0"),
            // createdAt: object['created_at'] ?? "",
            // updatedAt: object['updated_at'] ?? "",

            id: object['id'] ?? 0,
            name: object['name'] ?? "",
            tipePresensi: object['tipe_presensi'] ?? "",
            waktuMasuk: object['waktu_masuk'] ?? "",
            waktuKeluar: object['waktu_keluar'] ?? "",
            image: object['image'] ?? "",
            statusVerifikasi: object['status_verifikasi'] ?? "",
            siswaId: object['siswa_id'] ?? 0,
            tipePresensiId: object['tipe_presensi_id'] ?? 0,
            semesterId: object['semester_id'] ?? 0,
            tahunAjaranId: object['tahunAjaran_id'] ?? 0,
            createdAt: object['created_at'] ?? "",
            updatedAt: object['updated_at'] ?? "",
          );
        }).toList();

        // print(kelass);

        return presensis;
      } else {
        // final presensi = jsonDecode(response.body)['data'] as List;
        // print(presensi);
        return [];
      }
    } catch (e) {
      // print(e);
      throw Exception("Get presensi gagal.\nError: $e");
    }
  }

  Future<bool> verifyPresence(
    String presensiId,
    String statusVerifikasi,
  ) async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String? token = await storage.read(key: "token");
    String apiURL = "${baseAPIURL()}/guru-verifikasi-presensi/$presensiId";

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(
          true,
          token: token,
        ),
        body: {
          'status_verifikasi': statusVerifikasi,
        },
      );

      if (response.statusCode == 200) {
        // print(response.body);
        return true;
      } else {
        // print(response.body);
        return false;
      }
    } catch (e) {
      // print(e);
      throw Exception("Verifikasi presensi gagal.\nError: $e");
    }
  }
}
