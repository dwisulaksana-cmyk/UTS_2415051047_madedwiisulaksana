import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ormawa_model.dart';
import '../models/saved_ormawa_model.dart';
import '../providers/saved_ormawa_provider.dart';

class AddSavedOrmawaScreen extends StatefulWidget {
  final OrmawaModel ormawa;

  const AddSavedOrmawaScreen({super.key, required this.ormawa});

  @override
  State<AddSavedOrmawaScreen> createState() => _AddSavedOrmawaScreenState();
}

class _AddSavedOrmawaScreenState extends State<AddSavedOrmawaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _divisionController = TextEditingController();
  final _noteController = TextEditingController();
  int _priority = 3;

  @override
  void dispose() {
    _divisionController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<SavedOrmawaProvider>();
    final newItem = SavedOrmawaModel(
      studentNim: SavedOrmawaProvider.defaultStudentNim,
      ormawaId: widget.ormawa.id,
      ormawaName: widget.ormawa.name,
      category: widget.ormawa.category,
      targetDivision: _divisionController.text.trim(),
      note: _noteController.text.trim(),
      priority: _priority,
    );

    final success = await provider.addSavedOrmawa(newItem);
    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.ormawa.shortName} berhasil disimpan ke daftar minat!'),
          backgroundColor: Colors.green.shade700,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage ?? 'Gagal menyimpan data'),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitting = context.watch<SavedOrmawaProvider>().isSubmitting;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simpan Minat Ormawa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.ormawa.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Kategori: ${widget.ormawa.category} • ${widget.ormawa.faculty}',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _divisionController,
                decoration: const InputDecoration(
                  labelText: 'Divisi / Bidang yang Diminati',
                  hintText: 'Contoh: Bidang Penalaran & Keilmuan / Humas',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Divisi yang diminati wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                initialValue: _priority,
                decoration: const InputDecoration(
                  labelText: 'Tingkat Prioritas Pendaftaran',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('1 - Sangat Rendah')),
                  DropdownMenuItem(value: 2, child: Text('2 - Rendah')),
                  DropdownMenuItem(value: 3, child: Text('3 - Sedang')),
                  DropdownMenuItem(value: 4, child: Text('4 - Tinggi')),
                  DropdownMenuItem(value: 5, child: Text('5 - Prioritas Utama')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _priority = val);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Catatan / Alasan Bergabung',
                  hintText: 'Tuliskan motivasi atau jadwal open recruitment...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return 'Catatan minimal 5 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isSubmitting ? null : _submitForm,
                  icon: isSubmitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.save),
                  label: Text(isSubmitting ? 'Menyimpan...' : 'Simpan ke Database'),
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
      ),
    );
  }
}