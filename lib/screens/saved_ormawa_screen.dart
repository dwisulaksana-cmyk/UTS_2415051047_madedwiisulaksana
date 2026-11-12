import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/saved_ormawa_model.dart';
import '../providers/saved_ormawa_provider.dart';
import '../widgets/state_view_widget.dart';
import 'edit_saved_ormawa_screen.dart';

class SavedOrmawaScreen extends StatelessWidget {
  const SavedOrmawaScreen({super.key});

  Future<void> _confirmDelete(BuildContext context, SavedOrmawaModel item) async {
    if (item.id == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Ormawa Tersimpan?'),
        content: Text('Apakah kamu yakin ingin menghapus "${item.ormawaName}" dari daftar minat?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final provider = context.read<SavedOrmawaProvider>();
      final success = await provider.deleteSavedOrmawa(item.id!);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'Berhasil menghapus dari daftar tersimpan'
                  : (provider.errorMessage ?? 'Gagal menghapus data'),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final savedProvider = context.watch<SavedOrmawaProvider>();
    final savedList = savedProvider.savedList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ormawa Tersimpan'),
        actions: [
          IconButton(
            tooltip: 'Muat Ulang',
            icon: const Icon(Icons.refresh),
            onPressed: () => savedProvider.loadSavedOrmawa(),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (savedProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (savedProvider.errorMessage != null && savedList.isEmpty) {
            return StateViewWidget(
              icon: Icons.error_outline,
              iconColor: Colors.red.shade700,
              title: 'Gagal Memuat Data Tersimpan',
              subtitle: savedProvider.errorMessage!,
              actionLabel: 'Coba Lagi',
              onAction: () => savedProvider.loadSavedOrmawa(),
            );
          }

          if (savedList.isEmpty) {
            return const StateViewWidget(
              icon: Icons.bookmark_border,
              title: 'Belum Ada Ormawa Tersimpan',
              subtitle: 'Jelajahi katalog dan simpan organisasi mahasiswa yang kamu minati.',
            );
          }

          return RefreshIndicator(
            onRefresh: () => savedProvider.loadSavedOrmawa(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: savedList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = savedList[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0D47A1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                item.category,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Prioritas ${item.priority}/5',
                                style: TextStyle(
                                  color: Colors.amber.shade900,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              tooltip: 'Edit Catatan',
                              icon: const Icon(Icons.edit_outlined, color: Color(0xFF0D47A1)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditSavedOrmawaScreen(savedOrmawa: item),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              tooltip: 'Hapus',
                              icon: Icon(Icons.delete_outline, color: Colors.red.shade700),
                              onPressed: () => _confirmDelete(context, item),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.ormawaName,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Divisi Target: ${item.targetDivision}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0D47A1),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.note,
                          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}