import 'package:flutter/material.dart';
import '../widgets/state_view_widget.dart';

class SavedOrmawaScreen extends StatelessWidget {
  const SavedOrmawaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ormawa Tersimpan'),
      ),
      body: const StateViewWidget(
        icon: Icons.bookmark_border,
        title: 'Belum Ada Ormawa Tersimpan',
        subtitle: 'Jelajahi katalog dan simpan organisasi mahasiswa yang kamu minati.',
      ),
    );
  }
}