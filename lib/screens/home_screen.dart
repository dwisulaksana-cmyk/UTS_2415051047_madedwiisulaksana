import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ormawa_provider.dart';
import '../providers/saved_ormawa_provider.dart';

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
    final totalOrmawa = context.watch<OrmawaProvider>().allOrmawa.length;
    final totalSaved = context.watch<SavedOrmawaProvider>().savedList.length;

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
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Ormawa',
                    '$totalOrmawa Organisasi',
                    Icons.groups,
                    const Color(0xFF0D47A1),
                    onExploreTap,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Minat Tersimpan',
                    '$totalSaved Pilihan',
                    Icons.bookmark,
                    const Color(0xFFE65100),
                    onSavedTap,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
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
                _buildCategoryTile(context, Icons.account_balance, 'BEM', 'Eksekutif Mahasiswa', const Color(0xFF0D47A1)),
                _buildCategoryTile(context, Icons.gavel, 'MPM', 'Legislatif Mahasiswa', const Color(0xFF4A148C)),
                _buildCategoryTile(context, Icons.school, 'HMJ', 'Himpunan Jurusan', const Color(0xFF00695C)),
                _buildCategoryTile(context, Icons.sports_soccer, 'UKM', 'Minat & Bakat', const Color(0xFFE65100)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.12),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                    Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTile(
    BuildContext context,
    IconData icon,
    String category,
    String subtitle,
    Color color,
  ) {
    return InkWell(
      onTap: () {
        context.read<OrmawaProvider>().setCategory(category);
        onExploreTap();
      },
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
                  Text(category, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
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