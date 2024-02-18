class EPelitaModel {
  int? id, siswaId;
  String? kategoriPengaduan, detailPengaduan, bukti;
  DateTime? createdAt, updatedAt;

  EPelitaModel({
    required this.id,
    required this.kategoriPengaduan,
    required this.detailPengaduan,
    required this.bukti,
    required this.siswaId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EPelitaModel.fromJson(Map<String, dynamic> object) {
    return EPelitaModel(
      id: object['id'],
      kategoriPengaduan: object['kategori_pengaduan'],
      detailPengaduan: object['detail_pengaduan'],
      bukti: object['bukti'],
      siswaId: object['siswa_id'],
      createdAt: DateTime.parse(object['created_at']),
      updatedAt: DateTime.parse(object['updated_at']),
    );
  }
}
