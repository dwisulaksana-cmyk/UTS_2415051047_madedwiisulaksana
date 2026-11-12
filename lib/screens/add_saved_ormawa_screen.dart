import 'package:flutter/material.dart';
import '../models/ormawa_model.dart';

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Menyimpan ${widget.ormawa.shortName}...')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Text('Kategori: ${widget.ormawa.category}'),
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
                  onPressed: _submitForm,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan ke Database'),
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