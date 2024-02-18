import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import '../common/theme.dart';
import 'package:path/path.dart' as path;
import '../models/user_model.dart';

class UserService {
  AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }

  Future<UserModel> getGuru() async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String apiURL = "${baseAPIURL()}/guru";
    String token = await storage.read(key: "token") ?? "";

    try {
      var response = await get(
        Uri.parse(apiURL),
        headers: header(
          true,
          token: token,
        ),
      );

      // print("Euy: ${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);

        // print(jsonObject);

        return UserModel.fromJson(jsonObject);
      } else {
        var jsonObject = jsonDecode(response.body);
        // print(jsonObject);
        return UserModel.fromJson(jsonObject);
      }
    } catch (e) {
      // print("" + e.toString());
      throw Exception("Get Gagal.\nError: $e");
    }
  }

  Future<UserModel> addProfilePicure(File image) async {
    String apiURL = "${baseAPIURL()}/siswa-pengaduan";
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String? token = await storage.read(key: "token");

    try {
      var stream = ByteStream(image.openRead());
      stream.cast();
      var length = await image.length();
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

      request.files.add(
        MultipartFile(
          "image",
          stream,
          length,
          filename: path.basename(image.path),
        ),
      );

      Response response = await Response.fromStream(
        await request.send(),
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);

        // print(jsonObject);

        return UserModel.fromJson(jsonObject['data']);
      } else {
        // print("Gagal $jsonObject");
        throw Exception(
            "Tambah Foto Profil Gagal.\nError: ${response.statusCode}");
      }
    } catch (e) {
      // print("anime test $e");
      throw Exception("Tambah Foto Profil Gagal.\nError: $e");
    }
  }
}
