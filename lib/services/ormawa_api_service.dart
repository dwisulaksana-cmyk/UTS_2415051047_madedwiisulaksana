import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/ormawa_model.dart';

class OrmawaApiException implements Exception {
  final String message;

  OrmawaApiException(this.message);

  @override
  String toString() => message;
}

class OrmawaApiService {
  String get _baseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  String get _anonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  Future<List<OrmawaModel>> fetchOrmawaCatalog() async {
    if (_baseUrl.isEmpty || _anonKey.isEmpty) {
      throw OrmawaApiException(
        'Konfigurasi Supabase pada file .env belum lengkap.',
      );
    }

    try {
      final uri = Uri.parse(
        '$_baseUrl/rest/v1/ormawa?select=*&order=id.asc',
      );

      final response = await http
          .get(
            uri,
            headers: {
              'apikey': _anonKey,
              'Authorization': 'Bearer $_anonKey',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw OrmawaApiException(
          'Gagal mengambil data organisasi. '
          'HTTP Status: ${response.statusCode}.',
        );
      }

      final dynamic decoded = json.decode(response.body);

      if (decoded is! List) {
        throw const FormatException(
          'Format respons API tidak sesuai.',
        );
      }

      return decoded.map((item) {
        if (item is! Map<String, dynamic>) {
          throw const FormatException(
            'Format data organisasi tidak valid.',
          );
        }

        return OrmawaModel.fromJson(item);
      }).toList();
    } on OrmawaApiException {
      rethrow;
    } on TimeoutException {
      throw OrmawaApiException(
        'Koneksi ke server mengalami timeout. Silakan coba lagi.',
      );
    } on http.ClientException {
      throw OrmawaApiException(
        'Tidak dapat terhubung ke server. Periksa koneksi internet.',
      );
    } on FormatException {
      throw OrmawaApiException(
        'Data dari server tidak dapat dibaca.',
      );
    } catch (e) {
      throw OrmawaApiException(
        'Terjadi kesalahan saat mengambil data organisasi: $e',
      );
    }
  }
}
