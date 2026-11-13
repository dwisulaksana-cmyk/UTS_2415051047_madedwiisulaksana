import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';
import '../models/saved_ormawa_model.dart';
import '../repositories/ormawa_repository.dart';

class SavedOrmawaProvider extends ChangeNotifier {
  final OrmawaRepository _repository;
  static const String defaultStudentNim = AppConstants.studentNim;

  SavedOrmawaProvider({OrmawaRepository? repository})
      : _repository = repository ?? OrmawaRepository();

  List<SavedOrmawaModel> _savedList = [];
  bool _isLoading = false;
  bool _isSubmitting = false;
  String? _errorMessage;

  List<SavedOrmawaModel> get savedList => _savedList;
  bool get isLoading => _isLoading;
  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;

  bool isOrmawaSaved(int ormawaId) {
    return _savedList.any((item) => item.ormawaId == ormawaId);
  }

  Future<void> loadSavedOrmawa({String nim = defaultStudentNim}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _savedList = await _repository.getStudentSavedOrmawa(nim);
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addSavedOrmawa(SavedOrmawaModel item) async {
    _isSubmitting = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.saveOrmawa(item);
      await loadSavedOrmawa(nim: item.studentNim);
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  Future<bool> updateSavedOrmawa(int id, SavedOrmawaModel updatedItem) async {
    _isSubmitting = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.editSavedOrmawa(id, updatedItem);
      await loadSavedOrmawa(nim: updatedItem.studentNim);
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  Future<bool> deleteSavedOrmawa(int id) async {
    _errorMessage = null;
    try {
      await _repository.removeSavedOrmawa(id);
      _savedList.removeWhere((item) => item.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }
}
