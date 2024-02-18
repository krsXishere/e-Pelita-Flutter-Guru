import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import '../common/theme.dart';
import '../models/auth_model.dart';

class AuthService {
  AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }

  Future<AuthModel> signIn(
    String email,
    String password,
  ) async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String apiURL = "${baseAPIURL()}/guru-sign-in";

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(false),
        body: {
          'email': email,
          'password': password,
        },
      );

      // print("Euy: ${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        await storage.write(key: 'token', value: jsonObject['message']);

        return AuthModel.fromJson(jsonObject);
      } else {
        var jsonObject = jsonDecode(response.body);
        // print(jsonObject);
        return AuthModel.fromJson(jsonObject);
      }
    } catch (e) {
      // print(e);
      throw Exception("Sign In Gagal.\nError: $e");
    }
  }

  Future<AuthModel> signUp(
    String nip,
    String name,
    String email,
    String password,
    String mataPelajaran,
    String noWA,
    String sekolahId,
  ) async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String apiURL = "${baseAPIURL()}/guru-sign-up";
    // print(apiURL);

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(false),
        body: {
          'nip': nip,
          'name': name,
          'email': email,
          'password': password,
          'mata_pelajaran': mataPelajaran,
          'no_wa': noWA,
          'sekolah_id': sekolahId,
        },
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        await storage.write(key: 'token', value: jsonObject['message']);

        return AuthModel.fromJson(jsonObject);
      } else {
        var jsonObject = jsonDecode(response.body);
        // print(jsonObject);
        return AuthModel.fromJson(jsonObject);
      }
    } catch (e) {
      // print("EUY"+e.toString());
      throw Exception("Sign Up Gagal.\nError: $e");
    }
  }

  Future<bool> signOut() async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String? token = await storage.read(key: "token");
    var tokenId = token?.substring(0, token.indexOf("|"));
    String apiURL = "${baseAPIURL()}/guru-sign-out/$tokenId";

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(
          true,
          token: token,
        ),
      );

      if (response.statusCode == 200) {
        await storage.delete(key: "token");

        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Sign Up Gagal.\nError: $e");
    }
  }
}