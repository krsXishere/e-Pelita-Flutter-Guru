import 'dart:io';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  UserService userService = UserService();
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  File? _file;
  File? get file => _file;

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  checkFile(File? value) {
    _file = value;
    notifyListeners();
  }

  deleteFile() {
    if (_file != null) {
      _file!.writeAsString('');
      _file = null;
      notifyListeners();
    }
  }

  Future<bool> getGuru() async {
    checkLoading(true);

    try {
      final data = await userService.getGuru();

      _userModel = data;
      checkLoading(true);

      return true;
    } catch (e) {
      checkLoading(true);

      return false;
    }
  }

  Future<bool> addProfilePicure(File image) async {
    checkLoading(true);

    try {
      final user = await userService.addProfilePicure(image);

      _userModel = user;
      checkLoading(false);

      return true;
    } catch (e) {
      Exception("Error: $e");
      checkLoading(false);

      return false;
    }
  }
}
