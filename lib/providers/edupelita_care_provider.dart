import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../models/e_pelita_model.dart';
import '../services/e_pelita_service.dart';

class EduPelitaCareProvider with ChangeNotifier {
  final _epelitaService = EPelitaService();
  EPelitaModel? _ePelitaModel;
  EPelitaModel? get ePelita => _ePelitaModel;
  File? _file;
  File? get file => _file;
  FilePickerResult? _filePicked;
  FilePickerResult? get filePicked => _filePicked;
  String _fileType = "";
  String get fileType => _fileType;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _kategoriPengaduan = "";
  String get kategoriPengaduan => _kategoriPengaduan;

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  checkFile(File? value) {
    _file = value;
    notifyListeners();
  }

  checkFilePicked(FilePickerResult? value) {
    _filePicked = value;
    notifyListeners();
  }

  newFile() {
   _file = File(_filePicked!.files.single.path!);
    notifyListeners();
  }

  deleteFile() {
    if (_file != null) {
      _file!.writeAsString('');
      _file = null;
      notifyListeners();
    }
  }

  deleteFilePicked() async {
    if (_filePicked != null) {
      _filePicked = null;
      notifyListeners();
    }
  }

  checkFileType(String value) {
    _fileType = value;
    notifyListeners();
  }

  updateKategoriPengaduan(String value) {
    _kategoriPengaduan = value;
    notifyListeners();
  }

  Future<bool> pengaduan(
    String kategoriPengaduan,
    String detailPengaduan,
    FilePickerResult? bukti,
  ) async {
    checkLoading(true);

    try {
      // print("anime");
      final data = await _epelitaService.pengaduan(
        kategoriPengaduan,
        detailPengaduan,
        bukti,
      );

      _ePelitaModel = data;

      checkLoading(false);

      return true;
    } catch (e) {
      // print("anime euy $e");
      checkLoading(false);
      Exception(e);

      return false;
    }
  }
}
