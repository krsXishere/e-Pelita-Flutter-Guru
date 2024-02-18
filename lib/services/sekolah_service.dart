import 'dart:convert';
import 'package:http/http.dart';
import '../common/theme.dart';
import '../models/sekolah_model.dart';

class SekolahService {
  Future<List<SekolahModel>> getSekolah() async {
    String apiURL = "${baseAPIURL()}/sekolah";

    try {
      var response = await get(
        Uri.parse(apiURL),
        headers: header(false),
      );

      if (response.statusCode == 200) {
        final sekolah = jsonDecode(response.body)['data'] as List;
        final sekolahs = sekolah.map((object) {
          return SekolahModel(
            id: object['id'],
            nss: object['nss'],
            npsn: object['npsn'],
            namaSekolah: object['nama_sekolah'],
            alamat: object['alamat'],
            noTelpon: object['no_telpon'],
            noFax: object['no_fax'],
            email: object['email'],
            kepalaSekolah: object['kepala_sekolah'],
            createdAt: object['created_at'],
            updatedAt: object['updated_at'],
          );
        }).toList();

        return sekolahs;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Get sekolah gagal.\nError: $e");
    }
  }
}
