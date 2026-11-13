import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 44,
              backgroundColor: Color(0xFF0D47A1),
              child: Icon(Icons.person, size: 48, color: Colors.white),
            ),
            const SizedBox(height: 12),
            const Text(
              'Made Dwi Sulaksana',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'NIM: ${AppConstants.studentNim} | Kelas: PTI 5B',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.school, color: Color(0xFF0D47A1)),
                    title: Text('Program Studi'),
                    subtitle: Text('Pendidikan Teknik Informatika - Undiksha'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.apps, color: Color(0xFF0D47A1)),
                    title: Text('Tentang Aplikasi'),
                    subtitle: Text('Explore Ormawa Undiksha v1.0.0 â€” Project UTS Pemrograman Mobile'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.storage, color: Color(0xFF0D47A1)),
                    title: Text('Arsitektur & Backend'),
                    subtitle: Text('Flutter + Provider + Supabase REST API & PostgreSQL'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
