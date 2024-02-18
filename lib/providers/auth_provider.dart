import 'package:e_pelita_guru/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final _authService = AuthService();
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  bool _isObsecure = true;
  bool get isObsecure => _isObsecure;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isObsecureConfirmation = true;
  bool get isObsecureConfirmation => _isObsecureConfirmation;
  int _indexWidget = 0;
  int get indexWidget => _indexWidget;
  String _sekolahId = "";
  String get sekolahId => _sekolahId;

  checkObsecure() {
    _isObsecure = !_isObsecure;
    notifyListeners();
  }

  checkObsecureConfirmation() {
    _isObsecureConfirmation = !_isObsecureConfirmation;
    notifyListeners();
  }

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  checkIndex(int value) {
    _indexWidget = value;
    notifyListeners();
  }

  checkSekolahId(String sekolahId) {
    _sekolahId = sekolahId;
    notifyListeners();
  }

  Future<bool> signIn(
    String email,
    String password,
  ) async {
    checkLoading(true);

    try {
      await _authService.signIn(
        email,
        password,
      );

      checkLoading(false);

      return true;
    } catch (e) {
      Exception("Error: $e");
      checkLoading(false);

      return false;
    }
  }

  Future<bool> signUp(
    String nip,
    String name,
    String email,
    String password,
    String mataPelajaran,
    String noWA,
    String sekolahId,
  ) async {
    checkLoading(true);

    try {
      await _authService.signUp(
        nip,
        name,
        email,
        password,
        mataPelajaran,
        noWA,
        sekolahId,
      );

      checkLoading(false);

      return true;
    } catch (e) {
      Exception("Error: $e");
      checkLoading(false);

      return false;
    }
  }

  Future<bool> signOut() async {
    checkLoading(true);

    try {
      await _authService.signOut();

      checkLoading(false);

      return true;
    } catch (e) {
      Exception("Error: $e");
      checkLoading(false);

      return false;
    }
  }
}
