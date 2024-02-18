class PresenceModel {
  int? id, siswaId, tipePresensiId, semesterId, tahunAjaranId;
  String? name,
      tipePresensi,
      waktuMasuk,
      waktuKeluar,
      image,
      statusVerifikasi,
      createdAt,
      updatedAt;

  PresenceModel({
    required this.id,
    required this.name,
    required this.tipePresensi,
    required this.waktuMasuk,
    required this.waktuKeluar,
    required this.image,
    required this.statusVerifikasi,
    required this.siswaId,
    required this.tipePresensiId,
    required this.semesterId,
    required this.tahunAjaranId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PresenceModel.fromJson(Map<String, dynamic> object) {
    return PresenceModel(
      // id: int.tryParse(object['id'] ?? "0"),
      // name: object['name'] ?? "",
      // tipePresensi: object['tipe_presensi'] ?? "",
      // waktuMasuk: object['waktu_masuk'] ?? "",
      // waktuKeluar: object['waktu_keluar'] ?? "",
      // image: object['image'] ?? "",
      // statusVerifikasi: object['status_verifikasi'] ?? "",
      // siswaId: int.tryParse(object['siswa_id'] ?? "0"),
      // tipePresensiId: int.tryParse(object['tipe_presensi_id'] ?? "0"),
      // semesterId: int.tryParse(object['semester_id'] ?? "0"),
      // tahunAjaranId: int.tryParse(object['tahunAjaran_id'] ?? "0"),
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
  }
}
