class KelasModel {
  int? id, sekolahId;
  String? kelas, createdAt, updatedAt;
  // DateTime? createdAt, updatedAt;

  KelasModel({
    required this.id,
    required this.sekolahId,
    required this.kelas,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KelasModel.fromJson(Map<String, dynamic> object) {
    return KelasModel(
      id: object['id'],
      sekolahId: object['sekolah_id'],
      kelas: object['kelas'],
      createdAt: object['created_at'] ?? "",
      updatedAt: object['updated_at'] ?? "",
    );
  }
}
