import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/saved_ormawa_model.dart';

class SavedOrmawaDbService {
  final SupabaseClient _client = Supabase.instance.client;
  static const String _tableName = 'saved_ormawa';

  Future<List<SavedOrmawaModel>> getSavedOrmawa(String studentNim) async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .eq('student_nim', studentNim)
          .order('priority', ascending: false)
          .order('created_at', ascending: false);

      return (response as List<dynamic>)
          .map((item) => SavedOrmawaModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Gagal memuat data dari database: $e');
    }
  }

  Future<void> createSavedOrmawa(SavedOrmawaModel data) async {
    try {
      await _client.from(_tableName).insert(data.toInsertJson());
    } catch (e) {
      throw Exception('Gagal menyimpan data ke database: $e');
    }
  }

  Future<void> updateSavedOrmawa(int id, SavedOrmawaModel data) async {
    try {
      await _client
          .from(_tableName)
          .update(data.toUpdateJson())
          .eq('id', id);
    } catch (e) {
      throw Exception('Gagal memperbarui data di database: $e');
    }
  }

  Future<void> deleteSavedOrmawa(int id) async {
    try {
      await _client.from(_tableName).delete().eq('id', id);
    } catch (e) {
      throw Exception('Gagal menghapus data dari database: $e');
    }
  }
}