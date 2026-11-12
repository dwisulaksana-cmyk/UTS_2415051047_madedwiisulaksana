import 'package:flutter/material.dart';
import '../models/ormawa_model.dart';
import 'add_saved_ormawa_screen.dart';

class OrmawaDetailScreen extends StatelessWidget {
  final OrmawaModel ormawa;

  const OrmawaDetailScreen({super.key, required this.ormawa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ormawa.shortName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D47A1).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.groups, size: 36, color: Color(0xFF0D47A1)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Chip(
                            label: Text(ormawa.category),
                            backgroundColor: const Color(0xFF0D47A1),
                            labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                            visualDensity: VisualDensity.compact,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ormawa.name,
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Lingkup: ${ormawa.faculty}',
                            style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Deskripsi Organisasi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(ormawa.description, style: const TextStyle(fontSize: 14, height: 1.5)),
            const SizedBox(height: 16),
            const Text('Visi & Fokus Kegiatan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(ormawa.vision, style: const TextStyle(fontSize: 14, height: 1.5)),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.camera_alt_outlined, color: Color(0xFF0D47A1)),
              title: const Text('Media Sosial Resmi'),
              subtitle: Text(ormawa.instagram),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddSavedOrmawaScreen(ormawa: ormawa),
                    ),
                  );
                },
                icon: const Icon(Icons.bookmark_add),
                label: const Text('Simpan ke Daftar Minat Saya'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}