class UserModel {
  int? id, sekolahId, status;
  String? nip,
      name,
      email,
      emailVerifiedAt,
      mataPelajaran,
      noWA,
      image,
      sekolah,
      createdAt,
      updatedAt,
      message;
  // DateTime? createdAt, updatedAt;

  UserModel({
    required this.id,
    required this.nip,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.mataPelajaran,
    required this.noWA,
    required this.image,
    required this.sekolahId,
    required this.sekolah,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> object) {
    return UserModel(
      id: object['data']['id'],
      nip: object['data']['nip'],
      name: object['data']['name'],
      email: object['data']['email'],
      emailVerifiedAt: object['data']['email_verified_at'],
      mataPelajaran: object['data']['mata_pelajaran'],
      noWA: object['data']['no_wa'],
      image: object['data']['image'],
      sekolahId: object['data']['sekolah']['sekolah_id'],
      sekolah: object['data']['sekolah']['nama_sekolah'],
      createdAt: object['data']['createdAt'],
      updatedAt: object['data']['updatedAt'],
      status: object['status'],
      message: object['message'],
    );
  }
}
