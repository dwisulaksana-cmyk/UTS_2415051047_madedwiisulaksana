import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/ormawa_model.dart';

class OrmawaApiService {
  String get _baseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  String get _anonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  Future<List<OrmawaModel>> fetchOrmawaCatalog() async {
    if (_baseUrl.isEmpty || _anonKey.isEmpty) {
      throw Exception('Konfigurasi SUPABASE_URL atau SUPABASE_ANON_KEY pada file .env belum diisi.');
    }

    final uri = Uri.parse('$_baseUrl/rest/v1/ormawa?select=*&order=id.asc');

    try {
      final response = await http.get(
        uri,
        headers: {
          'apikey': _anonKey,
          'Authorization': 'Bearer $_anonKey',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final List<dynamic> decoded = json.decode(response.body) as List<dynamic>;
        return decoded
            .map((item) => OrmawaModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Gagal mengambil data REST API (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan/API: $e');
    }
  }
}