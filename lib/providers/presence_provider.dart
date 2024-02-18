import 'package:flutter/material.dart';
import '../models/presence_model.dart';
import '../services/presence_service.dart';

class PresenceProvider with ChangeNotifier {
  final _presenceService = PresenceService();
  List<PresenceModel> _presence = [];
  List<PresenceModel> get presence => _presence;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getPresence(String kelasId) async {
    checkLoading(true);

    final data = await _presenceService.getPresensi(kelasId);
    _presence = data;

    checkLoading(false);
  }

  Future<bool> verifyPresence(
    String presensiId,
    String statusVerifikasi,
  ) async {
    checkLoading(true);

    try {
      await _presenceService.verifyPresence(
        presensiId,
        statusVerifikasi,
      );

      checkLoading(false);

      return true;
    } catch (e) {
      checkLoading(false);

      return false;
    }
  }
}
