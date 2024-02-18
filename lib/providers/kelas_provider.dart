import 'package:flutter/material.dart';
import '../models/kelas_model.dart';
import '../services/kelas_service.dart';

class KelasProvider with ChangeNotifier {
  final _kelasService = KelasService();
  List<KelasModel> _kelas = [];
  List<KelasModel> get kelas => _kelas;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getKelas() async {
    checkLoading(true);

    final data = await _kelasService.getkelas();
    _kelas = data;

    checkLoading(false);
  }
}