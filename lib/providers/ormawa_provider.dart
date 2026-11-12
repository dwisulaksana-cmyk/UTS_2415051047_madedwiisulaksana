import 'package:flutter/foundation.dart';
import '../models/ormawa_model.dart';
import '../repositories/ormawa_repository.dart';

class OrmawaProvider extends ChangeNotifier {
  final OrmawaRepository _repository;

  OrmawaProvider({OrmawaRepository? repository})
      : _repository = repository ?? OrmawaRepository();

  List<OrmawaModel> _allOrmawa = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  List<OrmawaModel> get allOrmawa => _allOrmawa;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  List<String> get categories => ['Semua', 'BEM', 'MPM', 'HMJ', 'UKM'];

  List<OrmawaModel> get filteredOrmawa {
    return _allOrmawa.where((item) {
      final matchesCategory = _selectedCategory == 'Semua' ||
          item.category.toUpperCase() == _selectedCategory.toUpperCase();

      final query = _searchQuery.toLowerCase().trim();
      final matchesSearch = query.isEmpty ||
          item.name.toLowerCase().contains(query) ||
          item.shortName.toLowerCase().contains(query) ||
          item.faculty.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  Future<void> loadOrmawaCatalog() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _allOrmawa = await _repository.getAllOrmawa();
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void resetFilters() {
    _selectedCategory = 'Semua';
    _searchQuery = '';
    notifyListeners();
  }
}