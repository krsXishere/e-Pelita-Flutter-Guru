import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import '../common/theme.dart';
import '../models/e_pelita_model.dart';
import 'package:path/path.dart' as path;

class EPelitaService {
  AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }

  Future<EPelitaModel> pengaduan(
    String kategoriPengaduan,
    String detailPengaduan,
    FilePickerResult? bukti,
  ) async {
    String apiURL = "${baseAPIURL()}/guru-pengaduan";
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String? token = await storage.read(key: "token");

    try {
      var request = MultipartRequest(
        'POST',
        Uri.parse(apiURL),
      );
      request.headers.addAll(
        {
          'Authorization': "Bearer $token",
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data',
        },
      );

      request.fields.addAll(
        {
          'kategori_pengaduan': kategoriPengaduan,
          'detail_pengaduan': detailPengaduan,
        },
      );

      if (bukti != null) {
        File file = File(bukti.files.single.path!);
        var stream = ByteStream(file.openRead());
        stream.cast();
        var length = await file.length();

        request.files.add(
          MultipartFile(
            "bukti",
            stream,
            length,
            filename: path.basename(file.path),
          ),
        );
      }

      Response response = await Response.fromStream(
        await request.send(),
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);

        // print(jsonObject);

        return EPelitaModel.fromJson(jsonObject['data']);
      } else {
        // var jsonObject = jsonDecode(response.body);

        // print("Gagal $jsonObject");
        throw Exception("Aduan Gagal.\nError: ${response.statusCode}");
      }
    } catch (e) {
      // print("anime test $e");
      throw Exception("Aduan Gagal.\nError: $e");
    }
  }
}
