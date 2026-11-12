import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onExploreTap;
  final VoidCallback onSavedTap;

  const HomeScreen({
    super.key,
    required this.onExploreTap,
    required this.onSavedTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Ormawa Undiksha'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selamat Datang, Mahasiswa Undiksha!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Temukan BEM, MPM, HMJ, dan Unit Kegiatan Mahasiswa (UKM) sesuai minat dan bakatmu.',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: onExploreTap,
                    icon: const Icon(Icons.explore),
                    label: const Text('Jelajahi Katalog Ormawa'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFB300),
                      foregroundColor: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Kategori Organisasi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.3,
              children: [
                _buildCategoryTile(Icons.account_balance, 'BEM', 'Eksekutif Mahasiswa', const Color(0xFF0D47A1)),
                _buildCategoryTile(Icons.gavel, 'MPM', 'Legislatif Mahasiswa', const Color(0xFF4A148C)),
                _buildCategoryTile(Icons.school, 'HMJ', 'Himpunan Jurusan', const Color(0xFF00695C)),
                _buildCategoryTile(Icons.sports_soccer, 'UKM', 'Minat & Bakat', const Color(0xFFE65100)),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF0D47A1),
                  child: Icon(Icons.bookmark, color: Colors.white),
                ),
                title: const Text('Daftar Ormawa Tersimpan', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Kelola pilihan Ormawa, divisi target, dan catatanmu'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: onSavedTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTile(IconData icon, String title, String subtitle, Color color) {
    return InkWell(
      onTap: onExploreTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: Colors.black54),
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