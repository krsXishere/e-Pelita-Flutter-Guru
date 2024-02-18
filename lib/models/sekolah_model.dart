class SekolahModel {
  int? id;
  String? nss, npsn, namaSekolah, alamat, noTelpon, noFax, email, kepalaSekolah;
  DateTime? createdAt, updatedAt;

  SekolahModel({
    required this.id,
    required this.nss,
    required this.npsn,
    required this.namaSekolah,
    required this.alamat,
    required this.noTelpon,
    required this.noFax,
    required this.email,
    required this.kepalaSekolah,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SekolahModel.fromJson(Map<String, dynamic> object) {
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
      createdAt: object['created_at'] ?? "",
      updatedAt: object['updated_at'] ?? "",
    );
  }
}
