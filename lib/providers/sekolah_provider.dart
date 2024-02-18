import 'package:flutter/material.dart';
import 'package:e_pelita_guru/models/sekolah_model.dart';
import 'package:e_pelita_guru/services/sekolah_service.dart';

class SekolahProvider with ChangeNotifier {
  final _sekolahService = SekolahService();
  List<SekolahModel> _sekolahs = [];
  List<SekolahModel> get sekolahs => _sekolahs;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getSekolah() async {
    checkLoading(true);
    final data = await _sekolahService.getSekolah();

    _sekolahs = data;
    checkLoading(false);
  }
}