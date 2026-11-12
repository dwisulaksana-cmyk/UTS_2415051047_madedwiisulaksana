import '../models/ormawa_model.dart';
import '../models/saved_ormawa_model.dart';
import '../services/ormawa_api_service.dart';
import '../services/saved_ormawa_db_service.dart';

class OrmawaRepository {
  final OrmawaApiService _apiService;
  final SavedOrmawaDbService _dbService;

  OrmawaRepository({
    OrmawaApiService? apiService,
    SavedOrmawaDbService? dbService,
  })  : _apiService = apiService ?? OrmawaApiService(),
        _dbService = dbService ?? SavedOrmawaDbService();

  // REST API Operation (GET)
  Future<List<OrmawaModel>> getAllOrmawa() {
    return _apiService.fetchOrmawaCatalog();
  }

  // Database CRUD Operations
  Future<List<SavedOrmawaModel>> getStudentSavedOrmawa(String nim) {
    return _dbService.getSavedOrmawa(nim);
  }

  Future<void> saveOrmawa(SavedOrmawaModel item) {
    return _dbService.createSavedOrmawa(item);
  }

  Future<void> editSavedOrmawa(int id, SavedOrmawaModel item) {
    return _dbService.updateSavedOrmawa(id, item);
  }

  Future<void> removeSavedOrmawa(int id) {
    return _dbService.deleteSavedOrmawa(id);
  }
}