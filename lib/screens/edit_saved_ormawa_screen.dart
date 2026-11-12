import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/saved_ormawa_model.dart';
import '../providers/saved_ormawa_provider.dart';

class EditSavedOrmawaScreen extends StatefulWidget {
  final SavedOrmawaModel savedOrmawa;

  const EditSavedOrmawaScreen({super.key, required this.savedOrmawa});

  @override
  State<EditSavedOrmawaScreen> createState() => _EditSavedOrmawaScreenState();
}

class _EditSavedOrmawaScreenState extends State<EditSavedOrmawaScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _divisionController;
  late TextEditingController _noteController;
  late int _priority;

  @override
  void initState() {
    super.initState();
    _divisionController = TextEditingController(text: widget.savedOrmawa.targetDivision);
    _noteController = TextEditingController(text: widget.savedOrmawa.note);
    _priority = widget.savedOrmawa.priority;
  }

  @override
  void dispose() {
    _divisionController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _updateForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (widget.savedOrmawa.id == null) return;

    final provider = context.read<SavedOrmawaProvider>();
    final updatedItem = SavedOrmawaModel(
      id: widget.savedOrmawa.id,
      studentNim: widget.savedOrmawa.studentNim,
      ormawaId: widget.savedOrmawa.ormawaId,
      ormawaName: widget.savedOrmawa.ormawaName,
      category: widget.savedOrmawa.category,
      targetDivision: _divisionController.text.trim(),
      note: _noteController.text.trim(),
      priority: _priority,
    );

    final success = await provider.updateSavedOrmawa(widget.savedOrmawa.id!, updatedItem);
    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Perubahan berhasil disimpan ke database!'),
          backgroundColor: Colors.green.shade700,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage ?? 'Gagal memperbarui data'),
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
        title: const Text('Edit Catatan Ormawa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.savedOrmawa.ormawaName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _divisionController,
                decoration: const InputDecoration(
                  labelText: 'Divisi / Bidang yang Diminati',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Divisi wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                initialValue: _priority,
                decoration: const InputDecoration(
                  labelText: 'Tingkat Prioritas',
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
                  labelText: 'Catatan / Motivasi',
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
                  onPressed: isSubmitting ? null : _updateForm,
                  icon: isSubmitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.check_circle),
                  label: Text(isSubmitting ? 'Menyimpan...' : 'Simpan Perubahan'),
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