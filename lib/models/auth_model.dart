class AuthModel {
  int? status;
  String? message;

  AuthModel({
    required this.status,
    required this.message,
  });

  factory AuthModel.fromJson(Map<String, dynamic> object) {
    return AuthModel(
      status: object['status'],
      message: object['message'],
    );
  }
}
